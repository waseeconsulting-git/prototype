######## auth

variable "region" {
    description = "provider region"
    type = string
    default = "ap-northeast-1"
}

variable "common_tags" {
    description = "Tags for all resources for AWS provider"
    type = object({
      ManagedBy = string
      Team = string
      author = string
    })
    default = {
      ManagedBy = "Terraform"
      Team = "Melanated-Cyber-Kings"
      author ="Vany"
    }
}

variable "project" {
  description = "project name"
  type = string
  default = "Armageddon"
}

variable "env" {
  description = "project environment"
  type = string
  default = "lab-1a"

  validation {
    condition = contains(["lab-1a", "lab-1b", "lab-1c"], var.env)
      error_message = "The environment must be one of: lab-1a, lab-1b or lab-1c"
  }
}
######## Network

variable "cidr_block" {
  description = "VPC cidr block"
  type = string
  default = "172.17.0.0/16"
}

variable "public_subnet_cidr" {
  description = "public subnet cidr range"
  type = string
  default = "172.17.1.0/24"
}

variable "private_subnet_cidr" {
  description = "private subnet cidr range"
  type = string
  default = "172.17.11.0/24"
}

variable "availability_zone" {
    description = "provider region"
    type = string
    default = "ap-northeast-1a"
}

variable "rtb_public_cidr" {
  description = "route table public cidr"
  type = string
  default = "0.0.0.0/0"
}

variable "http_ingress_rule" {
    description = "http ingress in security group sg-ec2-lab1a"
    type = object({
      cidr = string
      port = number
      description = string
    })
    default = {
      cidr = "0.0.0.0/0"
      port = 80
      description = "HTTP ingress rule"
    }
}

variable "tcp_ingress_rule" {
  description = "tcp ingress in security group sg-rds-lab1a"
  type = object({
      cidr = string
      port = number
      description = string
  })
  default = {
    cidr = "172.17.0.0/16"
    port = 3306
    description = "tcp ingress rule"
  }
}