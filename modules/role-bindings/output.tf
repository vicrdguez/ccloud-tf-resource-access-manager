output "created_rolebindings" {
  value = [for topic, rb in confluent_role_binding.role_binding : {
    topic     = topic
    role_name = rb.role_name
    principal = rb.principal
    }
  ]
}
