output "endpoint_ids" {
  description = "Map of VPC endpoint IDs by service name"
  value = {
    ssm            = try(aws_vpc_endpoint.ssm.id, "")
    ssmmessages    = try(aws_vpc_endpoint.ssm_messages.id, "")
    ec2messages    = try(aws_vpc_endpoint.ec2_messages.id, "")
    secretsmanager = try(aws_vpc_endpoint.secrets_manager.id, "")
    logs           = try(aws_vpc_endpoint.logs.id, "")
    s3             = [for ep in aws_vpc_endpoint.s3 : ep.id]
    kms            = try(aws_vpc_endpoint.kms[0].id, "")
  }
}

output "endpoint_dns_entries" {
  description = "DNS entries for each VPC endpoint"
  value = {
    ssm            = try(aws_vpc_endpoint.ssm.dns_entry, [])
    ssmmessages    = try(aws_vpc_endpoint.ssm_messages.dns_entry, [])
    ec2messages    = try(aws_vpc_endpoint.ec2_messages.dns_entry, [])
    secretsmanager = try(aws_vpc_endpoint.secrets_manager.dns_entry, [])
    logs           = try(aws_vpc_endpoint.logs.dns_entry, [])
    kms            = try(aws_vpc_endpoint.kms[0].dns_entry, [])
  }
}

output "endpoint_service_names" {
  description = "Service names of created endpoints"
  value = {
    ssm            = try(aws_vpc_endpoint.ssm.service_name, "")
    ssmmessages    = try(aws_vpc_endpoint.ssm_messages.service_name, "")
    ec2messages    = try(aws_vpc_endpoint.ec2_messages.service_name, "")
    secretsmanager = try(aws_vpc_endpoint.secrets_manager.service_name, "")
    logs           = try(aws_vpc_endpoint.logs.service_name, "")
    s3             = [for ep in aws_vpc_endpoint.s3 : ep.service_name]
    kms            = try(aws_vpc_endpoint.kms[0].service_name, "")
  }
}

output "endpoint_arns" {
  description = "ARNs of created VPC endpoints"
  value = {
    ssm            = try(aws_vpc_endpoint.ssm.arn, "")
    ssmmessages    = try(aws_vpc_endpoint.ssmmessages.arn, "")
    ec2messages    = try(aws_vpc_endpoint.ec2_messages.arn, "")
    secretsmanager = try(aws_vpc_endpoint.secrets_manager.arn, "")
    logs           = try(aws_vpc_endpoint.logs.arn, "")
    s3             = [for ep in aws_vpc_endpoint.s3 : ep.arn]
    kms            = try(aws_vpc_endpoint.kms[0].arn, "")
  }
}

output "s3_endpoint_prefix_list_ids" {
  description = "Prefix list IDs of all S3 gateway endpoints"
  value       = [for ep in aws_vpc_endpoint.s3 : ep.prefix_list_id]
}

output "interface_endpoint_security_group_id" {
  description = "Security group ID used for interface endpoints"
  value       = var.vpc_endpoint_sg_id
}

output "all_endpoint_ids_list" {
  description = "List of all VPC endpoint IDs"
  value = compact(flatten([
    try([aws_vpc_endpoint.ssm.id], []),
    try([aws_vpc_endpoint.ssm_messages.id], []),
    try([aws_vpc_endpoint.ec2_messages.id], []),
    try([aws_vpc_endpoint.secrets_manager.id], []),
    try([aws_vpc_endpoint.logs.id], []),
    [for ep in aws_vpc_endpoint.s3 : ep.id],
    try([aws_vpc_endpoint.kms[0].id], [])
  ]))
}

output "endpoint_count" {
  description = "Number of VPC endpoints created"
  value = length(compact(flatten([
    try([aws_vpc_endpoint.ssm.id], []),
    try([aws_vpc_endpoint.ssm_messages.id], []),
    try([aws_vpc_endpoint.ec2_messages.id], []),
    try([aws_vpc_endpoint.secrets_manager.id], []),
    try([aws_vpc_endpoint.logs.id], []),
    [for ep in aws_vpc_endpoint.s3 : ep.id],
    try([aws_vpc_endpoint.kms[0].id], [])
  ])))
}
