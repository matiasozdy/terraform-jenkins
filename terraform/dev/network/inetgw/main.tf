resource "aws_internet_gateway" "igw-1" {
    vpc_id = "${data.terraform_remote_state.remote_dev_vpc.vpc_id}"

    tags {
    }
}
