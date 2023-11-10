variable "environment_id" {
  type = string
}
variable "cluster_id" {
  type = string
}
variable "app_name" {
  type = string
}

variable "service_account_prefix" {
}

variable "service_account_suffix" {
}

variable "key_vault_id" {
  description = "Azure Key Vault ID used to store Confluent Cloud API Keys"
  type = string
}


