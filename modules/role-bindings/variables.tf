variable "environment_id" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "rolebindings" {
  type = list(object({
    resource_type = string
    name         = string
    role_name     = string
  }))
}

variable "service_account_id" {
  type = string
}
