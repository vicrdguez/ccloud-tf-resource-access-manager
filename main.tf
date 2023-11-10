data "confluent_environment" "env" {
  id = var.environment_id
}

data "confluent_kafka_cluster" "cluster" {
  id = var.cluster_id
  environment {
    id = data.confluent_environment.env.id
  }
}

# Creates topics
module "topics" {
  for_each       = { for topic in var.kafka_topics : topic.name => topic }
  source         = "./modules/topics"
  environment_id = data.confluent_environment.env.id
  cluster_id     = data.confluent_kafka_cluster.cluster.id
  topic          = each.value
  admin_sa = {
    id     = var.cluster_credentials.api_key
    secret = var.cluster_credentials.api_secret
  }
}

# Creates Service Accounts and API Keys
module "credentials" {
  for_each               = { for app in var.applications : app.name => app }
  source                 = "./modules/credentials"
  environment_id         = data.confluent_environment.env.id
  cluster_id             = data.confluent_kafka_cluster.cluster.id
  app_name               = each.value.name
  service_account_prefix = var.service_account_prefix
  service_account_suffix = var.service_account_suffix
  key_vault_id           = var.key_vault_id

  # providers = {
  #   azurerm = {
  #     subscription_id = var.subscription_id
  #     client_id       = var.client_id
  #     client_secret   = var.client_secret
  #     tenant_id       = var.tenant_id
  #   }
  # }
}

module "role_bindings" {
  for_each           = { for app in var.applications : app.name => app.rolebindings }
  source             = "./modules/role-bindings"
  environment_id     = data.confluent_environment.env.id
  cluster_id         = data.confluent_kafka_cluster.cluster.id
  rolebindings       = each.value
  service_account_id = module.credentials[each.key].service_account_id
  depends_on = [
    # module.topics,
    module.credentials
  ]
}

module "acls" {
  for_each           = { for app in var.applications : app.name => app.acls }
  source             = "./modules/acls"
  environment_id     = data.confluent_environment.env.id
  cluster_id         = data.confluent_kafka_cluster.cluster.id
  acls               = each.value
  service_account_id = module.credentials[each.key].service_account_id
  admin_sa = {
    id     = var.cluster_credentials.api_key
    secret = var.cluster_credentials.api_secret
  }
}
