output "topics" {
  value       = values(module.topics)[*].created_topic
  description = "Created topics"
}

output "app_configs" {
  value       = values(module.credentials)[*].app_config
  sensitive   = true
  description = "Application java configurations generated from the generated Service Accounts and API Keys"
}

output "rolebindings" {
  value       = { for app, rb in module.role_bindings : app => rb.created_rolebindings[*] }
  description = "Created RBAC rolebindings"
}

output "acls" {
  value       = { for app, acl in module.acls : app => acl.created_acls[*] }
  description = "Created ACLs"
}
