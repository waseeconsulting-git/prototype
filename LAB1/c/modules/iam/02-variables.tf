variable "region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "env_prefix" {
  type        = string
  description = "Environment prefix for naming VPC and subnets"
}

variable "kms_key_arn" {
  description = "KMS CMK ARN used to encrypt the Secrets Manager secret"
  type        = string
}

# ⭐ NEW: Secret ARN for least privilege
variable "secret_arn" {
  description = "ARN of the specific secret to allow access to"
  type        = string
  default     = ""
}


# ⭐ NEW: Log group name for CloudWatch permissions
variable "log_group_name" {
  description = "CloudWatch log group name for write permissions"
  type        = string
  default     = "/aws/ec2/lab-rds-app"
}

# ⭐ NEW: Optional EC2 describe permissions
variable "enable_ec2_describe" {
  description = "Whether to enable minimal EC2 describe permissions"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags for all IAM resources"
  type        = map(string)
  default     = {}
}