output "created_acls" {
  # value = confluent_kafka_acl.acls
  value = [for key, acl in confluent_kafka_acl.acls : {
    pattern       = split("@", key)[0]
    pattern_type  = acl.pattern_type
    operation     = acl.operation
    permission    = acl.permission
    principal     = acl.principal
    resource_type = acl.resource_type
    }
  ]
}
