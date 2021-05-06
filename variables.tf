variable "airflow_configuration_options" {
  description = "The airflow_configuration_options parameter specifies airflow override options. Check the Official documentation for all possible configuration options."
  default     = null
  type        = map(any)
}
variable "airflow_version" {
  description = "Airflow version of your environment, will be set by default to the latest version that MWAA supports."
  default     = null
}
variable "dag_s3_path" {
  description = "The relative path to the DAG folder on your Amazon S3 storage bucket. For example, dags. For more information, see Importing DAGs on Amazon MWAA."
}
variable "environment_class" {
  description = " Environment class for the cluster. Possible options are mw1.small, mw1.medium, mw1.large. Will be set by default to mw1.small. Please check the AWS Pricing for more information about the environment classes."
  default     = null
}
variable "execution_role_arn" {
  description = "Specify if create_role is false. The Amazon Resource Name (ARN) of the task execution role that the Amazon MWAA and its environment can assume. Check the official AWS documentation for the detailed role specification."
  default     = null
}
variable "kms_key" {
  description = "The Amazon Resource Name (ARN) of your KMS key that you want to use for encryption. Will be set to the ARN of the managed KMS key aws/airflow by default. Please check the Official Documentation for more information."
  default     = null
}
variable "logging_configuration" {
  description = "The Apache Airflow logs you want to send to Amazon CloudWatch Logs."
  type        = list(any)
}
variable "max_workers" {
  description = "The maximum number of workers that can be automatically scaled up. Value need to be between 1 and 25. Will be 10 by default."
  default     = 10
}
variable "min_workers" {
  description = "The minimum number of workers that you want to run in your environment. Will be 1 by default."
  default     = 1
}
variable "name" {
  description = "The name of the Apache Airflow Environment"
}
variable "security_group_ids" {
  description = "Security groups IDs for the environment. At least one of the security group needs to allow MWAA resources to talk to each other, otherwise MWAA cannot be provisioned."
  type        = list(any)
}
variable "subnet_ids" {
  description = "The private subnet IDs in which the environment should be created. MWAA requires two subnets."
  type        = list(any)
}
variable "plugins_s3_object_version" {
  description = "The plugins.zip file version you want to use."
  default     = null
}
variable "plugins_s3_path" {
  description = "The relative path to the plugins.zip file on your Amazon S3 storage bucket. For example, plugins.zip. If a relative path is provided in the request, then plugins_s3_object_version is required. For more information, see Importing DAGs on Amazon MWAA."
  default     = null
}
variable "requirements_s3_object_version" {
  description = "The requirements.txt file version you want to use."
  default     = null
}
variable "requirements_s3_path" {
  description = "The relative path to the requirements.txt file on your Amazon S3 storage bucket. For example, requirements.txt. If a relative path is provided in the request, then requirements_s3_object_version is required. For more information, see Importing DAGs on Amazon MWAA."
  default     = null
}
variable "source_bucket_arn" {
  description = "Just specify if create_bucket is false. The Amazon Resource Name (ARN) of your Amazon S3 storage bucket. For example, arn:aws:s3:::airflow-mybucketname."
  default     = null
}
variable "webserver_access_mode" {
  description = "Specifies whether the webserver should be accessible over the internet or via your specified VPC. Possible options: PRIVATE_ONLY (default) and PUBLIC_ONLY."
  default     = null
}
variable "weekly_maintenance_window_start" {
  description = "Specifies the start date for the weekly maintenance window."
  default     = null
}
variable "tags" {
  description = "A map of key=value pairs to associate with the resource."
  type        = map(any)
  default     = null
}
variable "create_bucket" {
  description = "Whether to create a Source S3 Bucket"
  default     = true
}
variable "create_role" {
  description = "Whether to create an Execution Role"
  default     = true
}
