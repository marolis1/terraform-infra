terraform {  
  backend "s3" {
      bucket = "danieloikle.terraform.state"
      key = "prod/network/terraform.tfstate"
      region = "us-east-1"
  }
}