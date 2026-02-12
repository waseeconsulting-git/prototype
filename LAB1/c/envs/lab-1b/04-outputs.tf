output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

##########################
# Private subnets
##########################
output "private_subnet_ids" {
  description = "List of private subnet IDs from the network module"
  value       = module.vpc.private_subnet_ids
}

##########################
# Private route tables
##########################
output "private_route_table_ids" {
  description = "List of private route table IDs from the network module"
  value       = module.vpc.private_route_table_ids
}

##########################
# IAM
##########################
# FIXED: IAM Role Name Output
output "iam_role_name" {
  description = "Name of the IAM role for EC2"
  value       = module.iam.ec2_role_name  # ✅ CORRECT OUTPUT NAME
}


output "iam_instance_profile_name" {
  description = "IAM Instance Profile name"
  value       = module.iam.instance_profile_name
}

##########################
# RDS
##########################
# output "port" {
#   value = module.rds.port
# }

output "address" {
  description = "RDS endpoint address"
  value       = module.rds.address
}
