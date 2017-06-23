variable "region" {
  default = "us-east-1"
}

variable "root_volume_size" {
  default = 10
}

variable "amiid" {
  default = "ami-cf68e0d8"
}

variable "config_key" {
  default = ""
}

variable "instancetype" {
 default = "t2.micro"
}

variable "iamprofile" {
 default = ""
}

variable "env" {
 default = "Dev"
}

variable "secgroups" {
 default = []
}

variable "instancesnum" {
 default = 1
}

variable "subnet" {
 type = "list"
 default = [""]
}

variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
