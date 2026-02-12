# VPC with only private subnets
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = merge(var.tags, {
    Name = "${var.prefix}-vpc"
  })
}
################################################################
# Private subnets only (no public subnets)
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]

  tags = merge(var.tags, {
    Name = "${var.prefix}-private-${count.index}"
    Type = "private"
  })
}

# Optional: NAT Gateway (if you need internet access for package installs)
resource "aws_nat_gateway" "main" {
  count = var.enable_nat_gateway ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.private[0].id  # NAT in private subnet needs route to IGW
  
  tags = merge(var.tags, {
    Name = "${var.prefix}-nat"
  })
  
  depends_on = [aws_internet_gateway.main]
}

resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? 1 : 0
  
  domain = "vpc"
  tags = merge(var.tags, {
    Name = "${var.prefix}-nat-eip"
  })
}

# Private route table (with optional NAT route)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.enable_nat_gateway ? aws_nat_gateway.main[0].id : null
    # If no NAT, traffic stays within VPC
  }

  tags = merge(var.tags, {
    Name = "${var.prefix}-private-rt"
  })
}

# Associate private subnets with private route table
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}