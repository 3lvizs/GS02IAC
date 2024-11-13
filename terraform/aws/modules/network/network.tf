resource "aws_vpc" "vpc" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = "true"
}

resource "aws_subnet" "sn_vpc_pub1a" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "sn_vpc_pub1b" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.0.2.0/24"
    availability_zone       = "us-east-1c"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw_vpc" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "rt_sn_vpc_pub" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_vpc.id
    }
}

resource "aws_route_table_association" "rt_sn_vpc_pub_To_sn_vpc_pub1a" {
  subnet_id      = aws_subnet.sn_vpc_pub1a.id
  route_table_id = aws_route_table.rt_sn_vpc_pub.id
}

resource "aws_route_table_association" "rt_sn_vpc_pub_To_sn_vpc_pub1b" {
  subnet_id      = aws_subnet.sn_vpc_pub1b.id
  route_table_id = aws_route_table.rt_sn_vpc_pub.id
}