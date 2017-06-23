variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "env" {
  default = "Dev"
}

variable "public_subnets_cidr" {
 default = "10.10.0.0/22,10.10.4.0/22,10.10.8.0/22"
}

variable "dmz_subnets_cidr" {
 default = "10.10.12.0/22,10.10.16.0/22,10.10.20.0/22"
}

variable "app_subnets_cidr" {
 default = "10.10.24.0/22,10.10.28.0/22,10.10.32.0/22"
}

variable "db_subnets_cidr" {
 default = "10.10.36.0/22,10.10.40.0/22,10.10.44.0/22"
}
