resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "Dev Vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id              = aws_vpc.vpc.id
  cidr_block          = "10.0.0.0/24"
  availability_zone   = var.aws_availability_zone
  tags = {
    Name = "Dev Public Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Dev Vpc Route Table"
  }
}

resource "aws_route_table_association" "rt-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.route-table.id
  depends_on = [
    aws_subnet.public-subnet,
    aws_route_table.route-table
  ]
}