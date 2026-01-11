provider "aws" {                                       
    region = var.region        
}

# VPC / Network Module

module "vpc" {
  source = "../../network"

  vpc_cidr_block  = var.vpc_cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  env_prefix      = local.name_prefix
  avail_zone = var.avail_zone
  rtb_public_cidr = var.rtb_public_cidr  # ✅ THIS LINE FIXES IT

}


# Security Module 
# module "security" {
#   source = "../../security"

#   env_prefix = local.name_prefix
#   vpc_id     = module.vpc.vpc_id
  
#   # Pass the complex list variable down to the module
#   ec2_ingress_rules = var.sg_rules_ec2
# }