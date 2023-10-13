# Managed By : CloudDrove 
# Copyright @ CloudDrove. All Right Reserved.

# ------------------------------------------------------------------------------
# Labels
# ------------------------------------------------------------------------------

variable "enabled" {
  type        = bool
  default     = false
  description = "Set to false to prevent the module from creating AWS Athena related resources."
}

variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-athena"
  description = "Terraform current module repo"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

# ------------------------------------------------------------------------------
# S3 Bucket
# ------------------------------------------------------------------------------

variable "bucket_label_order" {
  type        = list(any)
  default     = ["name"]
  description = "Label order, e.g. `name`,`application` for S3 Bucket."
}

variable "create_s3_bucket" {
  type        = bool
  default     = true
  description = "Conditionally create S3 bucket."
}

variable "bucket_name" {
  type        = string
  default     = "athena-bucket"
  description = "name of s3 bucket"
}

variable "bucket_versioning" {
  type        = bool
  default     = true
  description = "Enable Versioning of S3."
}

variable "bucket_acl" {
  type        = string
  default     = null
  description = "Canned ACL to apply to the S3 bucket."
}

variable "bucket_force_destroy" {
  type        = bool
  default     = false
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
}

# ------------------------------------------------------------------------------
# AWS KMS
# ------------------------------------------------------------------------------

variable "create_workgroup_kms_key" {
  description = "Enable the creation of a KMS key used by Athena workgroup."
  type        = bool
  default     = true
}

variable "create_database_kms_key" {
  description = "Enable the creation of a KMS key used by Athena database."
  type        = bool
  default     = true
}

variable "athena_kms_key" {
  description = "Use an existing KMS key for Athena if `create_workgroup_kms_key` is `false`."
  type        = string
  default     = null
}

variable "deletion_window_in_days" {
  type        = number
  default     = 7
  description = "Duration in days after which the key is deleted after destruction of the resource."
}

variable "kms_key_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the kms is enabled or disabled."
}

variable "multi_region" {
  type        = bool
  default     = true
  description = "Indicates whether the KMS key is a multi-Region (true) or regional (false) key."
}

# ------------------------------------------------------------------------------
# AWS Athena
# ------------------------------------------------------------------------------

variable "athena_s3_bucket_id" {
  description = "Use an existing S3 bucket for Athena query results if `create_s3_bucket` is `false`."
  type        = string
  default     = null
}

variable "bytes_scanned_cutoff_per_query" {
  description = "Integer for the upper data usage limit (cutoff) for the amount of bytes a single query in a workgroup is allowed to scan. Must be at least 10485760."
  type        = number
  default     = null
}

variable "enforce_workgroup_configuration" {
  description = "Boolean whether the settings for the workgroup override client-side settings."
  type        = bool
  default     = true
}

variable "publish_cloudwatch_metrics_enabled" {
  description = "Boolean whether Amazon CloudWatch metrics are enabled for the workgroup."
  type        = bool
  default     = true
}

variable "workgroup_encryption_option" {
  description = "Indicates whether Amazon S3 server-side encryption with Amazon S3-managed keys (SSE_S3), server-side encryption with KMS-managed keys (SSE_KMS), or client-side encryption with KMS-managed keys (CSE_KMS) is used."
  type        = string
  default     = "SSE_KMS"
}

variable "s3_output_path" {
  description = "The S3 bucket path used to store query results."
  type        = string
  default     = ""
}

variable "workgroup_force_destroy" {
  description = "The option to delete the workgroup and its contents even if the workgroup contains any named queries."
  type        = bool
  default     = false
}

variable "databases" {
  description = "Map of Athena databases and related configuration."
  type        = map(any)
}

variable "data_catalogs" {
  description = "Map of Athena data catalogs and related configuration."
  type        = map(any)
  default     = {}
}

variable "named_queries" {
  description = "Map of Athena named queries and related configuration."
  type        = map(map(string))
  default     = {}
}
