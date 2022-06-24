terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.8.0"
    }
  }
}

data "aws_subnet" "sub1" {
    filter {
        name   = "tag:Name"
        values = ["${var.env}-subnet-1"]
  }
}

data "aws_vpc" "vpc1" {
    filter {
        name   = "tag:Name"
        values = ["${var.env}-vpc"]
  }
}

resource "aws_security_group" "allow_ssh" {
  name = "${var.env}-runner1-sg"
  vpc_id = data.aws_vpc.vpc1.id
  description = "Allow SSH ingress only"

  ingress {
    description = "SSH ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Allow outbound all"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
  Name: "${var.env}-runner1-sg"
  project: var.project_tag
  }
}

resource "aws_instance" "gitlab_runner1" {
  ami = "ami-0cff7528ff583bf9a"
  subnet_id = data.aws_subnet.sub1.id
  instance_type = "t2.medium"

  vpc_security_group_ids = [ aws_security_group.allow_ssh.id ]
  tags = {
    Name: "${var.env}-runner1"
    project: var.project_tag
    }
}
