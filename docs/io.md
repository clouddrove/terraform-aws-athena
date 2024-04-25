## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| athena\_kms\_key | Use an existing KMS key for Athena if `create_workgroup_kms_key` is `false`. | `string` | `null` | no |
| athena\_s3\_bucket\_id | Use an existing S3 bucket for Athena query results if `create_s3_bucket` is `false`. | `string` | `null` | no |
| bucket\_acl | Canned ACL to apply to the S3 bucket. | `string` | `null` | no |
| bucket\_force\_destroy | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| bucket\_label\_order | Label order, e.g. `name`,`application` for S3 Bucket. | `list(any)` | <pre>[<br>  "name"<br>]</pre> | no |
| bucket\_name | name of s3 bucket | `string` | `"athena-bucket"` | no |
| bucket\_versioning | Enable Versioning of S3. | `bool` | `true` | no |
| bytes\_scanned\_cutoff\_per\_query | Integer for the upper data usage limit (cutoff) for the amount of bytes a single query in a workgroup is allowed to scan. Must be at least 10485760. | `number` | `null` | no |
| create\_database\_kms\_key | Enable the creation of a KMS key used by Athena database. | `bool` | `true` | no |
| create\_s3\_bucket | Conditionally create S3 bucket. | `bool` | `true` | no |
| create\_workgroup\_kms\_key | Enable the creation of a KMS key used by Athena workgroup. | `bool` | `true` | no |
| data\_catalogs | Map of Athena data catalogs and related configuration. | `map(any)` | `{}` | no |
| databases | Map of Athena databases and related configuration. | `map(any)` | n/a | yes |
| deletion\_window\_in\_days | Duration in days after which the key is deleted after destruction of the resource. | `number` | `7` | no |
| enabled | Set to false to prevent the module from creating AWS Athena related resources. | `bool` | `false` | no |
| enforce\_workgroup\_configuration | Boolean whether the settings for the workgroup override client-side settings. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| kms\_key\_enabled | Specifies whether the kms is enabled or disabled. | `bool` | `true` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| multi\_region | Indicates whether the KMS key is a multi-Region (true) or regional (false) key. | `bool` | `true` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| named\_queries | Map of Athena named queries and related configuration. | `map(map(string))` | `{}` | no |
| publish\_cloudwatch\_metrics\_enabled | Boolean whether Amazon CloudWatch metrics are enabled for the workgroup. | `bool` | `true` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-athena"` | no |
| s3\_output\_path | The S3 bucket path used to store query results. | `string` | `""` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(any)` | `{}` | no |
| workgroup\_encryption\_option | Indicates whether Amazon S3 server-side encryption with Amazon S3-managed keys (SSE\_S3), server-side encryption with KMS-managed keys (SSE\_KMS), or client-side encryption with KMS-managed keys (CSE\_KMS) is used. | `string` | `"SSE_KMS"` | no |
| workgroup\_force\_destroy | The option to delete the workgroup and its contents even if the workgroup contains any named queries. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_arn | ID of S3 bucket used by Athena. |
| bucket\_id | ID of S3 bucket used by Athena. |
| data\_catalogs | List of newly created Athena data catalogs. |
| databases | List of newly created Athena databases. |
| kms\_key\_arn | ARN of KMS key used by Athena. |
| named\_queries | List of newly created Athena named queries. |
| workgroup\_id | ID of newly created Athena workgroup. |

