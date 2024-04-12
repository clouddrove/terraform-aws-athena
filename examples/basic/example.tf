
# Managed By : CloudDrove 
# Copyright @ CloudDrove. All Right Reserved.

##------------------------------------------------------------------------------
## Provider
##------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

##------------------------------------------------------------------------------
## AWS Athena Module
##------------------------------------------------------------------------------

module "athena" {
  source                  = "../../"
  name                    = "athena"
  environment             = "test"
  label_order             = ["name", "environment"]
  enabled                 = true
  workgroup_force_destroy = true

  # S3 Bucket Configuration
  bucket_force_destroy = true
  s3_output_path       = "accessLogs/queryresults/" # The S3 bucket path used to store query results
  bucket_versioning    = true

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
}