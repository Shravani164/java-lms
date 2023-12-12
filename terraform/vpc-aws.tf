#vpc without NAT and Elastic IP
provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAVYNZWER4HE4F47G7"
  secret_key = "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"
}
resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "terraform_vpc"
  }
}
resource "aws_subnet" "pub" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "pub_sub"
  }
}
resource "aws_subnet" "pvt" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "pvt_sub"
  }
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "IGW"
  }
}
resource "aws_route_table" "rt1" {
    vpc_id = aws_vpc.vpc.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table" "rt2" {
    vpc_id = aws_vpc.vpc.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "rt1_asc" {
    subnet_id      = aws_subnet.pub.id
    route_table_id = aws_route_table.rt1.id
}
resource "aws_route_table_association" "rt2_asc" {
    subnet_id      = aws_subnet.pvt.id
    route_table_id = aws_route_table.rt2.id
}
resource "aws_security_group" "allow_tls" {
    name        = "lms-SG"
    description = "Allow TLS inbound traffic"
    vpc_id      = aws_vpc.vpc.id
    ingress {
      description      = "TLS from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.vpc.cidr_block]
    }
    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
    tags = {
      Name = "lms-SG"
  }
}
