############################
# VPC
############################
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

############################
# Private Subnets
############################
output "private_subnet_ids" {
  description = "List of all private subnet IDs"
  value = [
    aws_subnet.private_1a.id,
    aws_subnet.private_2a.id,
    aws_subnet.private_1c.id
  ]
}

# Optional: single private subnet (first one) if a module requires only one subnet
output "first_private_subnet_id" {
  description = "The first private subnet ID"
  value       = aws_subnet.private_1a.id
}

############################
# Private Route Tables
############################
output "private_route_table_ids" {
  description = "List of all private route table IDs"
  value = [
    aws_route_table.private_1a.id,
    aws_route_table.private_2a.id,
    aws_route_table.private_1c.id
  ]
}

# Optional: single route table (first one) if a module requires only one
output "first_private_route_table_id" {
  description = "The first private route table ID"
  value       = aws_route_table.private_1a.id
}

############################
# DB Subnet Group
############################
output "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  value       = aws_db_subnet_group.this.name
}
