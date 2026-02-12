############################
# VPC Endpoint IDs
############################
output "endpoint_ids" {
  description = "Map of VPC endpoint IDs by service name"
  value = {
    ssm            = try(aws_vpc_endpoint.ssm.id, "")
    ssm_messages   = try(aws_vpc_endpoint.ssm_messages.id, "")
    ec2_messages   = try(aws_vpc_endpoint.ec2_messages.id, "")
    secretsmanager = try(aws_vpc_endpoint.secrets_manager.id, "")
    logs           = try(aws_vpc_endpoint.logs.id, "")
    s3             = try(values(aws_vpc_endpoint.s3)[0].id, "")
    kms            = try(aws_vpc_endpoint.kms[0].id, "")
  }
}

############################
# VPC Endpoint ARNs
############################
output "endpoint_arns" {
  description = "ARNs of created VPC endpoints"
  value = {
    ssm            = try(aws_vpc_endpoint.ssm.arn, "")
    ssm_messages   = try(aws_vpc_endpoint.ssm_messages.arn, "")
    ec2_messages   = try(aws_vpc_endpoint.ec2_messages.arn, "")
    secretsmanager = try(aws_vpc_endpoint.secrets_manager.arn, "")
    logs           = try(aws_vpc_endpoint.logs.arn, "")
    s3             = try(values(aws_vpc_endpoint.s3)[0].arn, "")
    kms            = try(aws_vpc_endpoint.kms[0].arn, "")
  }
}

############################
# VPC Endpoint Service Names
############################
output "endpoint_service_names" {
  description = "Service names of created endpoints"
  value = {
    ssm            = try(aws_vpc_endpoint.ssm.service_name, "")
    ssm_messages   = try(aws_vpc_endpoint.ssm_messages.service_name, "")
    ec2_messages   = try(aws_vpc_endpoint.ec2_messages.service_name, "")
    secretsmanager = try(aws_vpc_endpoint.secrets_manager.service_name, "")
    logs           = try(aws_vpc_endpoint.logs.service_name, "")
    s3             = try(values(aws_vpc_endpoint.s3)[0].service_name, "")
    kms            = try(aws_vpc_endpoint.kms[0].service_name, "")
  }
}

############################
# VPC Endpoint DNS Entries (Interface Endpoints only)
############################
output "endpoint_dns_entries" {
  description = "DNS entries for each VPC endpoint"
  value = {
    ssm            = try(aws_vpc_endpoint.ssm.dns_entry, [])
    ssm_messages   = try(aws_vpc_endpoint.ssm_messages.dns_entry, [])
    ec2_messages   = try(aws_vpc_endpoint.ec2_messages.dns_entry, [])
    secretsmanager = try(aws_vpc_endpoint.secrets_manager.dns_entry, [])
    logs           = try(aws_vpc_endpoint.logs.dns_entry, [])
    kms            = try(aws_vpc_endpoint.kms[0].dns_entry, [])
  }
}

############################
# S3 Gateway Endpoint Prefix List
############################
output "s3_endpoint_prefix_list_id" {
  description = "Prefix list ID of S3 gateway endpoint"
  value = try(values(aws_vpc_endpoint.s3)[0].prefix_list_id, "")
}

############################
# Security Group used for Interface Endpoints
############################
output "interface_endpoint_security_group_id" {
  description = "Security group ID used for interface endpoints"
  value       = var.vpc_endpoint_sg_id
}

############################
# List of all Endpoint IDs
############################
output "all_endpoint_ids_list" {
  description = "List of all VPC endpoint IDs"
  value = compact([
    try(aws_vpc_endpoint.ssm.id, ""),
    try(aws_vpc_endpoint.ssm_messages.id, ""),
    try(aws_vpc_endpoint.ec2_messages.id, ""),
    try(aws_vpc_endpoint.secrets_manager.id, ""),
    try(aws_vpc_endpoint.logs.id, ""),
    try(values(aws_vpc_endpoint.s3)[0].id, ""),
    try(aws_vpc_endpoint.kms[0].id, "")
  ])
}

############################
# Count of all Endpoints
############################
output "endpoint_count" {
  description = "Number of VPC endpoints created"
  value = length(compact([
    try(aws_vpc_endpoint.ssm.id, ""),
    try(aws_vpc_endpoint.ssm_messages.id, ""),
    try(aws_vpc_endpoint.ec2_messages.id, ""),
    try(aws_vpc_endpoint.secrets_manager.id, ""),
    try(aws_vpc_endpoint.logs.id, ""),
    try(values(aws_vpc_endpoint.s3)[0].id, ""),
    try(aws_vpc_endpoint.kms[0].id, "")
  ]))
}
