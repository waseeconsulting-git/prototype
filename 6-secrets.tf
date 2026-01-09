resource "aws_secretsmanager_secret" "rds_secret" {
  name = "lab/rds/mysql"
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_secret.id

  secret_string = jsonencode({
    username = "admin"
    password = "StrongPassword123!"
    host     = "PLACEHOLDER"
    port     = 3306
    dbname   = "labdb"
  })
}