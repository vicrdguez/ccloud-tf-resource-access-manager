# Configure the Confluent Provider
terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.54.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.72.0"
    }

    # local = {
    #   source  = "hashicorp/local"
    #   version = "2.4.0"
    # }
  }
}


