variable "env" {
    description = "The environment in which the resources will exist; prod, dev, qa, staging, etc"
    type = string
    default = "prod"
}

variable "project_tag" {
    description = "tag for identification of resources for usage/billing/etc"
    type = string
    default = "prod-network"
} 

variable "vpc_cidr" {
    description = "CIDR block used for the VPC"
    type = string
    default = "10.128.0.0/16"
}

variable "sub_cidr" {
    description = "CIDR block used for the subnet"
    type = list(string)
    default = [ "10.128.0.0/24", "10.128.1.0/24", "10.128.2.0/24", "10.128.3.0/24", "10.128.4.0/24", "10.128.5.0/24" ]
}

variable "az" {
    description = "Availability zone (format: us-east-1a, us-west-1b, etc)"
    type = list(string)
    default = [ "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f" ]
}