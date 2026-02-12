variable "db_endpoint" {
  description = "RDS endpoint for lab application"
  type        = string
  default     = ""   # optional
}



variable "port" {
  description = "RDS port"
  type        = string
}

variable "dbname" {
  description = "RDS database name"
  type        = string
}

variable "username" {
  description = "RDS username"
  type        = string
  sensitive   = true
}

variable "password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

variable "secret_arn" {
  description = "ARN of the RDS secret"
  type        = string
}

variable "secret_name" {
  description = "Name of the RDS secret"
  type        = string
}
