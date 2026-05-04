resource "aws_vpc" "secVPC" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "three-tier-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.secVPC.id

  tags = {
    Name = "three-tier-igw"
  }
}

resource "aws_subnet" "publicSubnet1" {
  vpc_id                  = aws_vpc.secVPC.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true

  tags = {
    Name = "public-web-subnet-1"
  }
}

resource "aws_subnet" "publicSubnet2" {
  vpc_id                  = aws_vpc.secVPC.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true

  tags = {
    Name = "public-web-subnet-2"
  }
}

resource "aws_subnet" "app_subnet_1" {
  vpc_id            = aws_vpc.secVPC.id
  cidr_block        = var.app_private_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "private-app-subnet-1"
  }
}

resource "aws_subnet" "app_subnet_2" {
  vpc_id            = aws_vpc.secVPC.id
  cidr_block        = var.app_private_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "private-app-subnet-2"
  }
}

resource "aws_subnet" "db_subnet_1" {
  vpc_id            = aws_vpc.secVPC.id
  cidr_block        = var.db_private_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "private-db-subnet-1"
  }
}

resource "aws_subnet" "db_subnet_2" {
  vpc_id            = aws_vpc.secVPC.id
  cidr_block        = var.db_private_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "private-db-subnet-2"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.secVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "three-tier-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_assoc1" {
  subnet_id      = aws_subnet.publicSubnet1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_assoc2" {
  subnet_id      = aws_subnet.publicSubnet2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "three-tier-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.publicSubnet1.id

  tags = {
    Name = "three-tier-nat-gw"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.secVPC.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "three-tier-private-rt"
  }
}

resource "aws_route_table_association" "private_rt_assoc1" {
  subnet_id      = aws_subnet.app_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_assoc2" {
  subnet_id      = aws_subnet.app_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}