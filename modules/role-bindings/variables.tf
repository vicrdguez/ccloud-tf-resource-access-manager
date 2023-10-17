variable "environment_id" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "rolebindings" {
  type = list(object({
      topic     = string
      role_name = string
    }))
}

variable "service_account_id" {
  type = string
}
