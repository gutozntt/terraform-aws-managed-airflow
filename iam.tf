########################################
# IAM Role
########################################

resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0
  name  = "${var.name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "airflow.amazonaws.com",
            "airflow-env.amazonaws.com"
          ]
        }
      }
    ]
  })

  tags = var.tags
}

########################################
# IAM Policy
########################################

resource "aws_iam_role_policy" "this" {
  count = var.create_role ? 1 : 0
  name  = "${var.name}-execution-policy"
  role  = aws_iam_role.this[0].id

  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": "airflow:PublishMetrics",
              "Resource": "arn:aws:airflow:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:environment/${var.name}"
          },
          {
              "Effect": "Deny",
              "Action": "s3:ListAllMyBuckets",
              "Resource": [
                  "${var.create_bucket ? aws_s3_bucket.this[0].arn : var.source_bucket_arn}",
                  "${var.create_bucket ? aws_s3_bucket.this[0].arn : var.source_bucket_arn}/*"
              ]
          },
          {
              "Effect": "Allow",
              "Action": [
                  "s3:GetObject*",
                  "s3:GetBucket*",
                  "s3:List*"
              ],
              "Resource": [
                  "${var.create_bucket ? aws_s3_bucket.this[0].arn : var.source_bucket_arn}",
                  "${var.create_bucket ? aws_s3_bucket.this[0].arn : var.source_bucket_arn}/*"
              ]
          },
          {
              "Effect": "Allow",
              "Action": [
                  "logs:CreateLogStream",
                  "logs:CreateLogGroup",
                  "logs:PutLogEvents",
                  "logs:GetLogEvents",
                  "logs:GetLogRecord",
                  "logs:GetLogGroupFields",
                  "logs:GetQueryResults"
              ],
              "Resource": [
                  "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.name}-*"
              ]
          },
          {
              "Effect": "Allow",
              "Action": [
                  "logs:DescribeLogGroups"
              ],
              "Resource": [
                  "*"
              ]
          },
          {
              "Effect": "Allow",
              "Action": "cloudwatch:PutMetricData",
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "sqs:ChangeMessageVisibility",
                  "sqs:DeleteMessage",
                  "sqs:GetQueueAttributes",
                  "sqs:GetQueueUrl",
                  "sqs:ReceiveMessage",
                  "sqs:SendMessage"
              ],
              "Resource": "arn:aws:sqs:${data.aws_region.current.name}:*:airflow-celery-*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "kms:Decrypt",
                  "kms:DescribeKey",
                  "kms:GenerateDataKey*",
                  "kms:Encrypt"
              ],
              "NotResource": "arn:aws:kms:*:${data.aws_caller_identity.current.account_id}:key/*",
              "Condition": {
                  "StringLike": {
                      "kms:ViaService": [
                          "sqs.${data.aws_region.current.name}.amazonaws.com"
                      ]
                  }
              }
          }
      ]
}
EOF
}
