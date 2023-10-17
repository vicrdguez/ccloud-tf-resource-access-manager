output "created_acls" {
  # value = confluent_kafka_acl.acls
  value = [for resource, acl in confluent_kafka_acl.acls : {
    pattern       = resource
    pattern_type  = acl.pattern_type
    operation     = acl.operation
    permission    = acl.permission
    principal     = acl.principal
    resource_type = acl.resource_type
    }
  ]
}
