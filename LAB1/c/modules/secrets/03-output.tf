# output "address" {
#     value = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)[address]
# }

# secrets/outputs.tf
output "secret_arn" {
  value = aws_secretsmanager_secret.rds_secret.arn
}

output "secret_name" {
  value = aws_secretsmanager_secret.rds_secret.name
}
