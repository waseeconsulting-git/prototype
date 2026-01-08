locals {
  name_prefix = "${var.project}-${var.env}"

  instance_type = {
    dev = "t3.micro"
    test = "t3.medium"
    prod = "t3.large"
  }

  managed_by = {
    ManagedBy = "Terraform"
  }

  merged_tags = merge(local.managed_by, var.common_tags)
}