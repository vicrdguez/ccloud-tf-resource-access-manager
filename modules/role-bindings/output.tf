output "created_rolebindings" {
  value = [for key, rb in confluent_role_binding.role_binding : {
    topic     = split("@", key)[0]
    role_name = rb.role_name
    principal = rb.principal
    }
  ]
}
