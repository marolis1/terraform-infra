terraform {  
  backend "s3" {
      bucket = "danieloikle.terraform.state"
      key = "prod/compute/runner/terraform.tfstate"
      region = "us-east-1"
  }
}