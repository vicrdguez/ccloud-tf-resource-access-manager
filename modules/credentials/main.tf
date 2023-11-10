
data "confluent_kafka_cluster" "cluster" {
  id = var.cluster_id
  environment {
    id = var.environment_id
  }
}
resource "confluent_service_account" "sa" {
  display_name = "${var.service_account_prefix}${var.app_name}${var.service_account_suffix}"
  description  = "Service Account for ${var.app_name}"
}

resource "confluent_api_key" "ak" {
  display_name = "${var.app_name}-api-key"
  description  = "Kafka API Key that is owned by ${var.app_name} service account"
  owner {
    id          = confluent_service_account.sa.id
    api_version = confluent_service_account.sa.api_version
    kind        = confluent_service_account.sa.kind
  }

  managed_resource {
    id          = data.confluent_kafka_cluster.cluster.id
    api_version = data.confluent_kafka_cluster.cluster.api_version
    kind        = data.confluent_kafka_cluster.cluster.kind

    environment {
      id = var.environment_id
    }
  }

  # It is recommended to set lifecycle { prevent_destroy = true } on production
  # instances to prevent accidental API Key deletion. This setting rejects plans
  # that would destroy or recreate the Key, such as attempting to change
  # uneditable attributes.
  lifecycle {
    prevent_destroy = false
  }

  depends_on = [confluent_service_account.sa]
}

resource "azurerm_key_vault_secret" "ccloud_ak" {
  name         = confluent_api_key.ak.id
  value        = confluent_api_key.ak.secret
  key_vault_id = var.key_vault_id

  depends_on = [confluent_api_key.ak]
}


# resource "local_file" "app_configs_file" {
#   content = <<-EOT
#   # Required connection configs for Kafka producer, consumer, and admin
#   bootstrap.servers=${data.confluent_kafka_cluster.cluster.bootstrap_endpoint}
#   security.protocol=SASL_SSL
#   sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username='${confluent_api_key.ak.id}' password='${confluent_api_key.ak.secret}';
#   sl.mechanism=PLAIN
#   # Required for correctness in Apache Kafka clients prior to 2.6
#   client.dns.lookup=use_all_dns_ips
#   # Best practice for higher availability in Apache Kafka clients prior to 3.0
#   session.timeout.ms=45000
#   # Best practice for Kafka producer to prevent data loss
#   acks=all
#   EOT
#
#   filename = "${path.module}/app-configs.txt"
#
# }
