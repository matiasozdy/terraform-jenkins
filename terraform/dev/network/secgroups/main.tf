resource "aws_security_group" "default" {
    name        = "Default"
    description = "Allow all ports within 10.10.0.0/16"
    vpc_id      = "${data.terraform_remote_state.remote_dev_vpc.vpc_id}"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["10.10.0.0/16"]
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "Name" = "All Ports in VPC 10.10"
    }
}
