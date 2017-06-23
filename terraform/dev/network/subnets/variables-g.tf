terraform {
  backend "s3" {
    bucket = "terraform-sb-st-dev"
    key = "dev-subnets-terraform.tfstate"
    encrypt = "true"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "remote_dev_vpc" {
  backend = "s3"
  config {
     bucket="terraform-sb-st-dev"
     key="dev-vpc-terraform.tfstate"
     region = "us-east-1"
  }
}
