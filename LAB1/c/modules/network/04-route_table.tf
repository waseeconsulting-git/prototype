############ Private Route Table ########################################################

resource "aws_route_table" "private_1a" {
  vpc_id = aws_vpc.main.id

  # No internet route required for RDS
  # AWS automatically adds the local VPC route

  tags = {
    Name = "${var.env_prefix}-private-rtb"
  }
}

resource "aws_route_table_association" "private_1a" {
  subnet_id      = aws_subnet.private_1a.id
  route_table_id = aws_route_table.private_1a.id
}
########################################################################################

resource "aws_route_table" "private_2a" {
  vpc_id = aws_vpc.main.id

  # No internet route required for RDS
  # AWS automatically adds the local VPC route

  tags = {
    Name = "${var.env_prefix}-private-rtb"
  }
}

resource "aws_route_table_association" "private_2a" {
  subnet_id      = aws_subnet.private_2a.id
  route_table_id = aws_route_table.private_2a.id
}
###########################################################################################
resource "aws_route_table" "private_1c" {
  vpc_id = aws_vpc.main.id

  # No internet route required for RDS
  # AWS automatically adds the local VPC route

  tags = {
    Name = "${var.env_prefix}-private-rtb"
  }
}

resource "aws_route_table_association" "private_1c" {
  subnet_id      = aws_subnet.private_1c.id
  route_table_id = aws_route_table.private_1c.id
}
############################################################################################



























