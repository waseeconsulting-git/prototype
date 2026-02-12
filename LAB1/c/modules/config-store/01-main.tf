# SSM Parameters for DB configuration
resource "aws_ssm_parameter" "db_endpoint" {
  count       = var.db_endpoint != "" ? 1 : 0
  name        = "/lab/db/endpoint"
  type        = "String"
  value       = var.db_endpoint
  description = "RDS endpoint for lab application"
  tags        = var.tags
}


resource "aws_ssm_parameter" "db_port" {
  name        = "/lab/db/port"
  type        = "String"
  value       = var.port
  description = "RDS port for lab application"
  tags        = var.tags
}

resource "aws_ssm_parameter" "db_name" {
  name        = "/lab/db/name"
  type        = "String"
  value       = var.dbname
  description = "RDS database name for lab application"
  tags        = var.tags
}

