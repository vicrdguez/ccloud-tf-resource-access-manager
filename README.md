<!-- BEGIN_TF_DOCS -->

Terrafom module to create and manage topics, and application credentials (Service Accounts, API Key
and API Secret). It generates outputs that are useful to query created resources and generate Java
configurations out of applications credentials. Check the `terraform.tfvars.sample` file for an
example of how to use the variables documented bellow
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_confluent"></a> [confluent](#requirement\_confluent) | 1.54.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_confluent"></a> [confluent](#provider\_confluent) | 1.54.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acls"></a> [acls](#module\_acls) | ./modules/acls | n/a |
| <a name="module_credentials"></a> [credentials](#module\_credentials) | ./modules/credentials | n/a |
| <a name="module_role_bindings"></a> [role\_bindings](#module\_role\_bindings) | ./modules/role-bindings | n/a |
| <a name="module_topics"></a> [topics](#module\_topics) | ./modules/topics | n/a |

## Resources

| Name | Type |
|------|------|
| [confluent_environment.env](https://registry.terraform.io/providers/confluentinc/confluent/1.54.0/docs/data-sources/environment) | data source |
| [confluent_kafka_cluster.cluster](https://registry.terraform.io/providers/confluentinc/confluent/1.54.0/docs/data-sources/kafka_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_applications"></a> [applications](#input\_applications) | List of applications to manage. Applications can optionally define<br>permissions: Role-bindings for RBAC and ACLs. A new API Key and a new Service Account will be <br>created for each application on this list. The resulting credentials can be queried via terraform<br>outputs. | <pre>list(object({<br>    name = string<br>    rolebindings = list(object({<br>      topic     = string<br>      role_name = string<br>    }))<br>    acls = list(object({<br>      resource_type = string<br>      resource_name = string<br>      pattern_type  = string<br>      operation     = string<br>      permission   = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_ccloud_api_key"></a> [ccloud\_api\_key](#input\_ccloud\_api\_key) | Confluent Cloud API Key | `string` | n/a | yes |
| <a name="input_ccloud_api_secret"></a> [ccloud\_api\_secret](#input\_ccloud\_api\_secret) | Confluent Cloud API Secret | `string` | n/a | yes |
| <a name="input_cluster_credentials"></a> [cluster\_credentials](#input\_cluster\_credentials) | Confluent Cloud **cluster** API Key and Secret | <pre>object({<br>    api_key    = string<br>    api_secret = string<br>  })</pre> | n/a | yes |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | The Confluent Cloud cluster you want to target for this deployment | `string` | n/a | yes |
| <a name="input_environment_id"></a> [environment\_id](#input\_environment\_id) | The Confluent Cloud environment you want to target for this deployment | `string` | n/a | yes |
| <a name="input_kafka_topics"></a> [kafka\_topics](#input\_kafka\_topics) | List of Topics and their configurations | <pre>list(object({<br>    name       = string<br>    partitions = number<br>    config     = map(string)<br>    consumer   = optional(string)<br>    producer   = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_service_account_prefix"></a> [service\_account\_prefix](#input\_service\_account\_prefix) | Name preffix for the Service Accounts created for each applications | `string` | `""` | no |
| <a name="input_service_account_suffix"></a> [service\_account\_suffix](#input\_service\_account\_suffix) | Name suffix for the Service Accounts created for each applications | `string` | `"-sa"` | no |

## Outputs

You can query outputs using:

```bash
terrafom output {{output-name}}
```

| Name | Description |
|------|-------------|
| <a name="output_acls"></a> [acls](#output\_acls) | Created ACLs |
| <a name="output_app_configs"></a> [app\_configs](#output\_app\_configs) | Application java configurations generated from the generated Service Accounts and API Keys |
| <a name="output_rolebindings"></a> [rolebindings](#output\_rolebindings) | Created RBAC rolebindings |
| <a name="output_topics"></a> [topics](#output\_topics) | Created topics |
<!-- END_TF_DOCS -->
