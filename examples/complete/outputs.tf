
# Managed By : CloudDrove 
# Copyright @ CloudDrove. All Right Reserved.

##------------------------------------------------------------------------------
## Outputs
##------------------------------------------------------------------------------

output "athena_s3_bucket_id" {
  description = "ID of S3 bucket used by Athena."
  value       = module.s3_bucket.id
}

output "athena_kms_key_arn" {
  description = "ARN of KMS key used by Athena."
  value       = module.athena.kms_key_arn
}

output "athena_workgroup_id" {
  description = "ID of newly created Athena workgroup."
  value       = module.athena.workgroup_id
}

output "athena_databases" {
  description = "List of newly created Athena databases."
  value       = module.athena.databases
}
