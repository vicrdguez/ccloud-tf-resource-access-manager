data "confluent_kafka_cluster" "cluster" {
  id = var.cluster_id
  environment {
    id = var.environment_id
  }
}

# locals {
#   rbac_crn = "crn://confluent.cloud/organization=c9bc4776-9ab9-473b-8b16-c76108251133/environment=env-pwn02/cloud-cluster=lkc-dgn6kd"
# }

resource "confluent_role_binding" "role_binding" {
  for_each    = { for rb in var.rolebindings : "${rb.topic}@${rb.role_name}" => rb }
  principal   = "User:${var.service_account_id}"
  role_name   = each.value.role_name
  crn_pattern = "${data.confluent_kafka_cluster.cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.cluster.id}/${lower(each.value.resource_type)}=${each.value.name}"
  # crn_pattern = "${local.rbac_crn}/kafka=${data.confluent_kafka_cluster.cluster.id}/topic=${each.key}"
  depends_on  = [data.confluent_kafka_cluster.cluster]
}
