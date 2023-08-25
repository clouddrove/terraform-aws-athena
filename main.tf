# Managed By : CloudDrove 
# Copyright @ CloudDrove. All Right Reserved.

##----------------------------------------------------------------------------- 
## Labels module callled that will be used for naming and tags.   
##-----------------------------------------------------------------------------
module "labels" {
  source      = "clouddrove/labels/aws"
  version     = "1.3.0"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  repository  = var.repository
  extra_tags  = var.tags
}

locals {
  s3_bucket_id = var.create_s3_bucket ? try(module.s3_bucket.id, null) : var.athena_s3_bucket_id
  kms_key_arn  = var.create_kms_key ? try(aws_kms_key.default[0].arn, null) : var.athena_kms_key
}

# ------------------------------------------------------------------------------
# S3 Bucket
# ------------------------------------------------------------------------------

module "s3_bucket" {
  source  = "clouddrove/s3/aws"
  version = "1.3.0"

  create_bucket = var.enabled && var.create_s3_bucket

  name          = format("%s-bucket-athena", var.name)
  label_order   = var.bucket_label_order
  versioning    = var.bucket_versioning
  acl           = var.bucket_acl
  force_destroy = var.bucket_force_destroy
}

# ------------------------------------------------------------------------------
# KMS Encryption
# ------------------------------------------------------------------------------

resource "aws_kms_key" "default" {
  count = var.enabled && var.create_kms_key ? 1 : 0

  deletion_window_in_days = var.athena_kms_key_deletion_window
  description             = "Athena KMS Key"
  tags                    = module.labels.tags
}

# ------------------------------------------------------------------------------
# AWS Athena Resources
# ------------------------------------------------------------------------------

resource "aws_athena_workgroup" "default" {
  count = var.enabled ? 1 : 0

  name = module.labels.id

  configuration {
    bytes_scanned_cutoff_per_query     = var.bytes_scanned_cutoff_per_query
    enforce_workgroup_configuration    = var.enforce_workgroup_configuration
    publish_cloudwatch_metrics_enabled = var.publish_cloudwatch_metrics_enabled

    result_configuration {
      encryption_configuration {
        encryption_option = var.workgroup_encryption_option
        kms_key_arn       = local.kms_key_arn
      }
      output_location = format("s3://%s/%s", local.s3_bucket_id, var.s3_output_path)
    }
  }

  force_destroy = var.workgroup_force_destroy

  tags = module.labels.tags
}

resource "aws_athena_database" "default" {
  for_each = var.enabled ? var.databases : {}

  name       = each.key
  bucket     = local.s3_bucket_id
  comment    = try(each.value.comment, null)
  properties = try(each.value.properties, null)

  dynamic "acl_configuration" {
    for_each = try(each.value.acl_configuration, null) != null ? ["true"] : []
    content {
      s3_acl_option = each.value.acl_configuration.s3_acl_option
    }
  }

  dynamic "encryption_configuration" {
    for_each = try(each.value.encryption_configuration, null) != null ? ["true"] : []
    content {
      encryption_option = each.value.encryption_configuration.encryption_option
      kms_key           = each.value.encryption_configuration.kms_key
    }
  }

  expected_bucket_owner = try(each.value.expected_bucket_owner, null)
  force_destroy         = try(each.value.force_destroy, false)

}

resource "aws_athena_data_catalog" "default" {
  for_each = var.enabled ? var.data_catalogs : {}

  name        = "${var.name}-${each.key}"
  description = each.value.description
  type        = each.value.type

  parameters = each.value.parameters

  tags = merge(
    module.labels.tags,
    { Name = "${var.name}-${each.key}" }
  )
}

resource "aws_athena_named_query" "default" {
  for_each = var.enabled ? var.named_queries : {}

  name        = "${var.name}-${each.key}"
  workgroup   = aws_athena_workgroup.default[0].id
  database    = aws_athena_database.default[each.value.database].name
  query       = format(each.value.query, each.value.database)
  description = each.value.description
}