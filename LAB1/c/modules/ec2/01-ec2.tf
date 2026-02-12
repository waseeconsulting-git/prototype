# Use data source for SSM-enabled AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]  # Amazon Linux 2023
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# PRIVATE EC2 instance
resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.amazon_linux.id  # NOT hardcoded
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id  # Private subnet from root
  vpc_security_group_ids = var.security_group_ids
  
  # ⭐ CRITICAL FIX: NO PUBLIC IP ⭐
  associate_public_ip_address = false  # WAS: true

  user_data = file("${path.module}/user_data.sh")
  iam_instance_profile = var.instance_profile_name

  # Add IMDSv2 for security
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = merge({
    Name = "${var.env_prefix}-ec2-app"
  }, var.tags)
}