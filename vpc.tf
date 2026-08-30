# =========================
# Availability Zones
# =========================

data "aws_availability_zones" "available" {
  state = "available"
}


# =========================
# VPC
# =========================

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vprofile-vpc"
  }
}


# =========================
# Internet Gateway
# =========================

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "vprofile-igw"
  }
}


# =========================
# Public Subnets
# =========================

resource "aws_subnet" "public" {
  count = 2

  vpc_id = aws_vpc.main.id

  cidr_block = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ][count.index]

  availability_zone = data.aws_availability_zones.available.names[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "vprofile-public-${count.index + 1}"
  }
}


# =========================
# Private Subnets
# =========================

resource "aws_subnet" "private" {
  count = 2

  vpc_id = aws_vpc.main.id

  cidr_block = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ][count.index]

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "vprofile-private-${count.index + 1}"
  }
}


# =========================
# Public Route Table
# =========================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "vprofile-public-rt"
  }
}


# =========================
# Public Route Associations
# =========================

resource "aws_route_table_association" "public" {
  count = 2

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public.id
}


# =========================
# Private Route Table
# =========================

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "vprofile-private-rt"
  }
}


# =========================
# Private Route Associations
# =========================

resource "aws_route_table_association" "private" {
  count = 2

  subnet_id = aws_subnet.private[count.index].id

  route_table_id = aws_route_table.private.id
}
