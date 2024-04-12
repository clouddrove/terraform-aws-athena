## Basic Example to create AWS Athena

This folder contains a basic example of how to use the terraform athena module to create an Athena workgroup, database. The table is based on a sample CSV file stored in an S3 bucket.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Inputs

- `name` : The name of the Athena workgroup. Required.
- `environment` : The environment of the Athena module created. Optional
- `label_order` : The label order of the module, used to create te name of Athena workgroup. e.g. ["name", "environment"] or ["name"] Optional
- `enabled` : The Bool value that refers the creation of AWS Athena resources. Optional
- `workgroup_force_destroy` : The option to delete the workgroup and its contents even if the workgroup contains any named queries. Optional
- `bucket_force_destroy` : A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. Optional
- `s3_output_path` : The S3 bucket path used to store query results. Optional
- `databases` : Map of Athena databases and related configuration. Required

## Outputs

- `athena_workgroup_id` : The ID of the Athena workgroup.
- `athena_databases` : The ID of the Athena database.
- `athena_s3_bucket_id` : The ID of the S3 bucket.