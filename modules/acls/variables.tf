variable "environment_id" {
  type = string
}

variable "cluster_id" {
  type = string
}

# Confluent Cloud Service Account  
variable "admin_sa" {
  type = object({
    id     = string
    secret = string
  })
}

variable "acls" {
  type = list(object({
      resource_type = string
      resource_name = string
      pattern_type  = string
      operation     = string
      permission   = string
    }))
}

variable "service_account_id" {
  type = string
}
