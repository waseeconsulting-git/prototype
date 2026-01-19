############################
# EC2 Security Group
############################
output "ec2_sg_id" {
  description = "Security group ID for EC2 instances / VPC endpoints"
  value       = aws_security_group.ec2_sg.id
}

############################
# RDS Security Group
############################
output "rds_sg_id" {
  description = "Security group ID for RDS instances"
  value       = aws_security_group.rds_sg.id
}
