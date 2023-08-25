
# Managed By : CloudDrove 
# Copyright @ CloudDrove. All Right Reserved.

# ------------------------------------------------------------------------------
# Provider
# ------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

# ------------------------------------------------------------------------------
# Provider
# ------------------------------------------------------------------------------
locals {
  name        = "athena"
  environment = "test"
  label_order = ["name", "environment"]
}

# ------------------------------------------------------------------------------
# AWS S3
# ------------------------------------------------------------------------------
module "s3_bucket" {
  source  = "clouddrove/s3/aws"
  version = "1.3.0"

  name          = format("%s-bucket-test", local.name)
  versioning    = true
  acl           = "private"
  force_destroy = true
}

resource "aws_kms_key" "database" {
  deletion_window_in_days = 7
  description             = "Athena KMS Key for Database"
}

# ------------------------------------------------------------------------------
# AWS Athena Module
# ------------------------------------------------------------------------------

module "athena" {
  source = "../../"

  name        = local.name
  environment = local.environment
  label_order = local.label_order

  enabled                 = true
  workgroup_force_destroy = true

  # S3 Bucket Configuration
  create_s3_bucket    = false
  athena_s3_bucket_id = module.s3_bucket.id
  s3_output_path      = "outputs/" # The S3 bucket path used to store query results

  # Database for Athena
  databases = {
    database1 = {
      force_destroy = true
      properties = {
        custom_prop_1 = "example"
      }
      encryption_configuration = {
        encryption_option = "SSE_KMS"
      }
    }
  }

  # Data catalog to test terraform
  data_catalogs = {
    glue1 = {
      description = "This is an example to test Terraform"
      type        = "GLUE"
      parameters = {
        catalog-id : "123456789012" # The catalog_id is the account ID of the AWS account to which the AWS Glue catalog belongs.
      }
    }
  }

  # Named Queries to test terarform
  named_queries = {
    query1 = {
      database    = "database1"
      description = "This is an example query to test Terraform"
      query       = "SELECT * FROM %s limit 10;"
    }
  }
}