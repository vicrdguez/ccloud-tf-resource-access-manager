data "confluent_kafka_cluster" "cluster" {
  id = var.cluster_id
  environment {
    id = var.environment_id
  }
}

resource "confluent_kafka_acl" "acls" {
  for_each = { for acl in var.acls : "${acl.resource_name}@${acl.operation}" => acl }
  kafka_cluster {
    id = data.confluent_kafka_cluster.cluster.id
  }
  rest_endpoint = data.confluent_kafka_cluster.cluster.rest_endpoint
  credentials  {
    key    = var.admin_sa.id
    secret = var.admin_sa.secret
  }
  resource_type = each.value.resource_type
  resource_name = each.value.resource_name
  pattern_type  = each.value.pattern_type
  principal     = "User:${var.service_account_id}"
  host          = "*"
  operation     = each.value.operation
  permission    = each.value.permission

  # lifecycle {
  #   prevent_destroy = true
  # }
}
