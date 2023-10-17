variable "environment_id" {
  type = string
}

variable "cluster_id" {
  type = string
}


# Topic definition list 
variable "topic" {
  type = object({
    name = string
    partitions = number
    config =  map(string)
  })
  description = "List of Topics. If RBAC enabled producer service account will be configured as DeveloperWrite and consumer will be configured as DeveloperRead."
}

# Confluent Cloud Service Account  
variable "admin_sa" {
  type = object({
    id     = string
    secret = string
  })
}



