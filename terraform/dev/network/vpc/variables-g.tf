terraform {
  backend "s3" {
    bucket = "terraform-sb-st-dev"
    key = "dev-vpc-terraform.tfstate"
    encrypt = "true"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}
