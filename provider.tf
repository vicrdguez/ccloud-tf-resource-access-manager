# Configure the Confluent Provider
terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.54.0"
    }
  }
}

# Access using cloud API Key
provider "confluent" {
  cloud_api_key    = var.ccloud_api_key    # optionally use CONFLUENT_CLOUD_API_KEY env var
  cloud_api_secret = var.ccloud_api_secret # optionally use CONFLUENT_CLOUD_API_SECRET env var
}
