variable "region" {
  type        = string
  description = "The AWS region to deploy resources in"
}



variable "vpc_cidr_block" {
  description = "VPC cidr block"
  type = string
}

#variable "env_prefix" {
#  type        = string
#  description = "Environment prefix for naming VPC and subnets"
#}

variable "env_prefix" {
  description = "project environment"
  type = string
  default = "lab-1a"

  validation {
    condition = contains(["lab-1a", "lab-1b", "lab-1c"], var.env_prefix)
      error_message = "The environment must be one of: lab-1a, lab-1b or lab-1c"
  }
}


variable "project" {
  description = "project name"
  type = string
}

variable "avail_zone" {
    description = "provider region, availability zone for resources"
    type = string
}

variable "public_subnet_cidr" {
  description = "public subnet cidr range"
  type = string
}

variable "private_subnet_cidr" {
  description = "private subnet cidr range"
  type = string
}

variable "rtb_public_cidr" {
  description = "route table public cidr"
  type = string
}

variable "my_ip" {
  description = "Your IP Address for SSH access (e.g., 1.2.3.4/32)"
  type        = string
}
variable "db_port" {
  description = "Port for Database"
  type        = number
}
variable "all_ips" {
  description = "CIDR block for the whole internet"
  type        = list(string)
}

variable "any_port" {
  description = "Port number representing 'any' port"
  type        = number
}

variable "any_protocol" {
  description = "Protocol string representing 'any' protocol"
  type        = string
}

# We define the list format here so we can pass it from tfvars
variable "sg_rules_ec2" {
  description = "Ingress rules for EC2"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}