output "ssm_parameter_names" {
  description = "SSM parameter names"
  value = {
    endpoint = try(aws_ssm_parameter.db_endpoint[0].name, "")  # db_endpoint uses count
    port     = aws_ssm_parameter.db_port.name                  # single instance
    name     = aws_ssm_parameter.db_name.name                  # single instance
  }
}


output "secret_arn" {
  description = "Secrets Manager secret ARN"
  value       = var.secret_arn
}

output "secret_name" {
  description = "Secrets Manager secret name"
  value       = var.secret_name
}

