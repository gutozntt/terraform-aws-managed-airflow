########################################
# Managed Workflow Apache Airflow
########################################

resource "aws_mwaa_environment" "this" {
  airflow_configuration_options   = var.airflow_configuration_options
  airflow_version                 = var.airflow_version
  dag_s3_path                     = var.dag_s3_path
  environment_class               = var.environment_class
  execution_role_arn              = var.create_role ? aws_iam_role.this[0].arn : var.execution_role_arn
  kms_key                         = var.kms_key
  max_workers                     = var.max_workers
  min_workers                     = var.min_workers
  name                            = var.name
  plugins_s3_object_version       = var.plugins_s3_object_version
  plugins_s3_path                 = var.plugins_s3_path
  requirements_s3_object_version  = var.requirements_s3_object_version
  requirements_s3_path            = var.requirements_s3_path
  source_bucket_arn               = var.create_bucket ? aws_s3_bucket.this[0].arn : var.source_bucket_arn
  webserver_access_mode           = var.webserver_access_mode
  weekly_maintenance_window_start = var.weekly_maintenance_window_start
  tags                            = var.tags

  dynamic "logging_configuration" {
    for_each = var.logging_configuration
    content {
      dag_processing_logs {
        enabled   = lookup(logging_configuration.value, "dag_enabled", false)
        log_level = lookup(logging_configuration.value, "dag_log_level", null)
      }
      scheduler_logs {
        enabled   = lookup(logging_configuration.value, "scheduler_logs_enabled", false)
        log_level = lookup(logging_configuration.value, "scheduler_log_level", null)
      }
      task_logs {
        enabled   = lookup(logging_configuration.value, "task_logs_enabled", false)
        log_level = lookup(logging_configuration.value, "task_log_level", null)
      }
      webserver_logs {
        enabled   = lookup(logging_configuration.value, "webserver_logs_enabled", false)
        log_level = lookup(logging_configuration.value, "webserver_log_level", null)
      }
      worker_logs {
        enabled   = lookup(logging_configuration.value, "worker_logs_enabled", false)
        log_level = lookup(logging_configuration.value, "worker_log_level", null)
      }
    }
  }

  network_configuration {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }
}

########################################
# S3 Bucket
########################################

resource "aws_s3_bucket" "this" {
  count  = var.create_bucket ? 1 : 0
  bucket = "${var.name}-vts-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  count  = var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  block_public_acls   = true
  block_public_policy = true
}
