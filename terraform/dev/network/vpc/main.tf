resource "aws_vpc" "vpc" {
    cidr_block           = "${var.cidrblock}"
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags {
        "Name" = "vpc-${lower(var.env)}"
    }
}
