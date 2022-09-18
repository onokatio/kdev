resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "default"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "default route for public subnet"
  }
}

resource "aws_route_table_association" "public-1a" {
  subnet_id = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-1c" {
  subnet_id = aws_subnet.public-1c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-1d" {
  subnet_id = aws_subnet.public-1d.id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "private-1a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  //ipv6_cidr_block = "2406:da14:66d:e900::/64"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "private-1a"
  }
}

resource "aws_subnet" "private-1c" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  //ipv6_cidr_block = "2406:da14:66d:e900::/64"
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "private-1c"
  }
}

resource "aws_subnet" "private-1d" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  //ipv6_cidr_block = "2406:da14:66d:e900::/64"
  availability_zone = "ap-northeast-1d"
  tags = {
    Name = "private-1d"
  }
}

resource "aws_subnet" "public-1a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.128.0/24"
  //ipv6_cidr_block = "2406:da14:66d:e900::/64"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-1a"
  }
}

resource "aws_subnet" "public-1c" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.129.0/24"
  //ipv6_cidr_block = "2406:da14:66d:e900::/64"
  availability_zone = "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-1c"
  }
}

resource "aws_subnet" "public-1d" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.130.0/24"
  //ipv6_cidr_block = "2406:da14:66d:e900::/64"
  availability_zone = "ap-northeast-1d"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-1d"
  }
}