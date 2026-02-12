


##########################################################


output "ec2_role_name" {
  description = "Name of the EC2 IAM role"
  value       = aws_iam_role.ec2_secrets_role.name
}

output "ec2_role_arn" {
  description = "ARN of the EC2 IAM role"
  value       = aws_iam_role.ec2_secrets_role.arn
}

output "instance_profile_name" {
  description = "Name of the EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "instance_profile_arn" {
  description = "ARN of the EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_profile.arn
}

output "secret_policy_arn" {
  description = "ARN of the secrets manager policy"
  value       = aws_iam_policy.ec2_secrets_policy.arn
}

output "ssm_policy_arn" {
  description = "ARN of the SSM parameter policy"
  value       = aws_iam_policy.ssm_read.arn
}