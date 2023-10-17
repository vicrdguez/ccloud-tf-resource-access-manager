variable "ccloud_api_key" {
  type = string
  description = "Confluent Cloud API Key"
}

variable "ccloud_api_secret" {
  type = string
  description = "Confluent Cloud API Secret"
}

variable "environment_id" {
  type = string
  description = "The Confluent Cloud environment you want to target for this deployment"
}

variable "cluster_id" {
  type = string
  description = "The Confluent Cloud cluster you want to target for this deployment"
}

# Topic definition list 
variable "kafka_topics" {
  type = list(object({
    name       = string
    partitions = number
    config     = map(string)
    consumer   = optional(string)
    producer   = optional(string)
  }))
  description = "List of Topics and their configurations"
}

variable "applications" {
  type = list(object({
    name = string
    rolebindings = list(object({
      topic     = string
      role_name = string
    }))
    acls = list(object({
      resource_type = string
      resource_name = string
      pattern_type  = string
      operation     = string
      permission   = string
    }))
  }))

  description = <<-EOT
  List of applications to manage. Applications can optionally define
  permissions: Role-bindings for RBAC and ACLs. A new API Key and a new Service Account will be 
  created for each application on this list. The resulting credentials can be queried via terraform
  outputs.
  EOT
}

variable "service_account_prefix" {
  default = ""
  description = "Name preffix for the Service Accounts created for each applications"
}

variable "service_account_suffix" {
  default = "-sa"
  description = "Name suffix for the Service Accounts created for each applications"
}

# Service Account Credentials
variable "cluster_credentials" {
  type = object({
    api_key    = string
    api_secret = string
  })
  description = "Confluent Cloud **cluster** API Key and Secret"
}
