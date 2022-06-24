terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.8.0"
    }
  }
}

resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr

    tags = {
    Name: "${var.env}-vpc"
    project: var.project_tag
    }
}

resource "aws_subnet" "subnets" {
    count = length(var.sub_cidr)

    vpc_id = aws_vpc.vpc.id
    cidr_block = var.sub_cidr[count.index]
    availability_zone = var.az[count.index]

    tags = {
    Name: "${var.env}-subnet-${count.index + 1}"
    project: var.project_tag
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
    Name: "${var.env}-igw"
    project: var.project_tag
    }
}

resource "aws_default_route_table" "rtb" {
    default_route_table_id = aws_vpc.vpc.default_route_table_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
    Name: "${var.env}-rtb"
    project: var.project_tag
    }
}