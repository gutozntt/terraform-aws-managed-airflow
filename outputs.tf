output "arn" {
  description = "The ARN of the MWAA Environment"
  value       = aws_mwaa_environment.this.arn
}
output "created_at" {
  description = "The Created At date of the MWAA Environment"
  value       = aws_mwaa_environment.this.created_at
}
output "service_role_arn" {
  description = "The Service Role ARN of the Amazon MWAA Environment"
  value       = aws_mwaa_environment.this.service_role_arn
}
output "status" {
  description = "The status of the Amazon MWAA Environment"
  value       = aws_mwaa_environment.this.status
}
output "webserver_url" {
  description = "The webserver URL of the MWAA Environment"
  value       = aws_mwaa_environment.this.webserver_url
}
