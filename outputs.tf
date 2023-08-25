# Managed By : CloudDrove 
# Copyright @ CloudDrove. All Right Reserved.

##------------------------------------------------------------------------------
## S3 Bucket Outputs
##------------------------------------------------------------------------------

output "bucket_id" {
  description = "ID of S3 bucket used by Athena."
  value       = try(module.s3_bucket.id, null)
}

output "bucket_arn" {
  description = "ID of S3 bucket used by Athena."
  value       = try(module.s3_bucket.arn, null)
}

##------------------------------------------------------------------------------
## KMS Encryption Outputs
##------------------------------------------------------------------------------

output "kms_key_arn" {
  description = "ARN of KMS key used by Athena."
  value       = try(aws_kms_key.default[0].arn, null)
}

##------------------------------------------------------------------------------
## AWS Athena Outputs
##------------------------------------------------------------------------------

output "workgroup_id" {
  description = "ID of newly created Athena workgroup."
  value       = try(aws_athena_workgroup.default[0].id, null)
}

output "databases" {
  description = "List of newly created Athena databases."
  value       = aws_athena_database.default
}

output "data_catalogs" {
  description = "List of newly created Athena data catalogs."
  value       = aws_athena_data_catalog.default
}

output "named_queries" {
  description = "List of newly created Athena named queries."
  value       = aws_athena_named_query.default
}
