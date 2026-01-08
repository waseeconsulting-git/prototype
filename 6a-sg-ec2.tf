resource "aws_security_group" "ec2-sg" {
  name        = "ec2-lab1a"
  description = "Allow inbound traffic and all outbound traffic to terraform ec2"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${local.name_prefix}-ec2-sg"
  }
}


resource "aws_vpc_security_group_ingress_rule" "ec2-http_ipv4" {
  description = var.http_ingress_rule.description
  security_group_id = aws_security_group.ec2-sg.id
  cidr_ipv4 = var.http_ingress_rule.cidr
  from_port         = var.http_ingress_rule.port
  ip_protocol       = "tcp"
  to_port           = var.http_ingress_rule.port

## tags to name the security group rule
   tags = {
     Name = "${local.name_prefix}-http"
   }
}


resource "aws_vpc_security_group_egress_rule" "ec2_all_outbound" {
  security_group_id = aws_security_group.ec2-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
