variable "subnet_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "env_prefix" {
  type = string
}

# ec2/variables.tf
variable "security_group_ids" {
  description = "List of security group IDs to attach to EC2 instance"
  type        = list(string)
}

variable "instance_profile_name" {
  description = "IAM instance profile name for EC2"
  type        = string
}

variable "ssm_param_path" {
  description = "SSM parameter path prefix"
  type        = string
  default     = "/lab/db"
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

variable "secret_id" {
  description = "Secrets Manager secret ID"
  type        = string
  default     = "lab/rds/mysql"
}

# ⭐ CRITICAL: IAM profile with SSM permissions
#variable "instance_profile_name" {
#  description = "IAM instance profile name (must have SSM permissions)"
#  type        = string
#}

variable "region" {
  type        = string
  description = "The AWS region to deploy resources in"
}