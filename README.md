# AWS Managed Airflow

Use this module to deploy an AWS Managed Airflow.

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.14.9 |
| aws | ~> 3.37.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.37.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| airflow\_configuration\_options | The airflow\_configuration\_options parameter specifies airflow override options. Check the Official documentation for all possible configuration options. | `map(any)` | `null` | no |
| airflow\_version | Airflow version of your environment, will be set by default to the latest version that MWAA supports. | `any` | `null` | no |
| create\_bucket | Whether to create a Source S3 Bucket | `bool` | `true` | no |
| create\_role | Whether to create an Execution Role | `bool` | `true` | no |
| dag\_s3\_path | The relative path to the DAG folder on your Amazon S3 storage bucket. For example, dags. For more information, see Importing DAGs on Amazon MWAA. | `any` | n/a | yes |
| environment\_class | Environment class for the cluster. Possible options are mw1.small, mw1.medium, mw1.large. Will be set by default to mw1.small. Please check the AWS Pricing for more information about the environment classes. | `any` | `null` | no |
| execution\_role\_arn | Specify if create\_role is false. The Amazon Resource Name (ARN) of the task execution role that the Amazon MWAA and its environment can assume. Check the official AWS documentation for the detailed role specification. | `any` | `null` | no |
| kms\_key | The Amazon Resource Name (ARN) of your KMS key that you want to use for encryption. Will be set to the ARN of the managed KMS key aws/airflow by default. Please check the Official Documentation for more information. | `any` | `null` | no |
| logging\_configuration | The Apache Airflow logs you want to send to Amazon CloudWatch Logs. | `list(any)` | n/a | yes |
| max\_workers | The maximum number of workers that can be automatically scaled up. Value need to be between 1 and 25. Will be 10 by default. | `number` | `10` | no |
| min\_workers | The minimum number of workers that you want to run in your environment. Will be 1 by default. | `number` | `1` | no |
| name | The name of the Apache Airflow Environment | `any` | n/a | yes |
| plugins\_s3\_object\_version | The plugins.zip file version you want to use. | `any` | `null` | no |
| plugins\_s3\_path | The relative path to the plugins.zip file on your Amazon S3 storage bucket. For example, plugins.zip. If a relative path is provided in the request, then plugins\_s3\_object\_version is required. For more information, see Importing DAGs on Amazon MWAA. | `any` | `null` | no |
| requirements\_s3\_object\_version | The requirements.txt file version you want to use. | `any` | `null` | no |
| requirements\_s3\_path | The relative path to the requirements.txt file on your Amazon S3 storage bucket. For example, requirements.txt. If a relative path is provided in the request, then requirements\_s3\_object\_version is required. For more information, see Importing DAGs on Amazon MWAA. | `any` | `null` | no |
| security\_group\_ids | Security groups IDs for the environment. At least one of the security group needs to allow MWAA resources to talk to each other, otherwise MWAA cannot be provisioned. | `list(any)` | n/a | yes |
| source\_bucket\_arn | Just specify if create\_bucket is false. The Amazon Resource Name (ARN) of your Amazon S3 storage bucket. For example, arn:aws:s3:::airflow-mybucketname. | `any` | `null` | no |
| subnet\_ids | The private subnet IDs in which the environment should be created. MWAA requires two subnets. | `list(any)` | n/a | yes |
| tags | A map of key=value pairs to associate with the resource. | `map(any)` | `null` | no |
| webserver\_access\_mode | Specifies whether the webserver should be accessible over the internet or via your specified VPC. Possible options: PRIVATE\_ONLY (default) and PUBLIC\_ONLY. | `any` | `null` | no |
| weekly\_maintenance\_window\_start | Specifies the start date for the weekly maintenance window. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the MWAA Environment |
| created\_at | The Created At date of the MWAA Environment |
| service\_role\_arn | The Service Role ARN of the Amazon MWAA Environment |
| status | The status of the Amazon MWAA Environment |
| webserver\_url | The webserver URL of the MWAA Environment |
