resource "aws_network_acl" "ACL-s-for-10-10-0-0-16" {
    vpc_id     = "${data.terraform_remote_state.remote_dev_vpc.vpc_id}"
    subnet_ids = ["${data.terraform_remote_state.remote_dev_subnets.app_subnet}"]

    ingress {
        from_port  = 0
        to_port    = 0
        rule_no    = 100
        action     = "allow"
        protocol   = "-1"
        cidr_block = "0.0.0.0/0"
    }

    ingress {
        from_port  = 0
        to_port    = 0
        rule_no    = 110
        action     = "allow"
        protocol   = "-1"
        cidr_block = "10.10.0.0/16"
    }

    egress {
        from_port  = 0
        to_port    = 0
        rule_no    = 100
        action     = "allow"
        protocol   = "-1"
        cidr_block = "0.0.0.0/0"
    }

    tags {
        "Name" = "ACL's for 10.10.0.0/16"
    }
}

