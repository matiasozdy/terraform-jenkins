resource "aws_subnet" "public" {
  vpc_id                  = "${data.terraform_remote_state.remote_dev_vpc.vpc_id}"
  cidr_block              = "${element(split(",", var.public_subnets_cidr), count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  count                   = "${length(split(",", var.public_subnets_cidr))}"

  tags {
    Name = "${lower(var.env)}-public-${element(var.azs, count.index)}"
  }
}

resource "aws_subnet" "dmz" {
  vpc_id                  = "${data.terraform_remote_state.remote_dev_vpc.vpc_id}"
  cidr_block              = "${element(split(",", var.dmz_subnets_cidr), count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  count                   = "${length(split(",", var.dmz_subnets_cidr))}"

  tags {
    Name = "${lower(var.env)}-dmz-${element(var.azs, count.index)}"
  }
}


resource "aws_subnet" "app" {
  vpc_id                  = "${data.terraform_remote_state.remote_dev_vpc.vpc_id}"
  cidr_block              = "${element(split(",", var.app_subnets_cidr), count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  count                   = "${length(split(",", var.app_subnets_cidr))}"

  tags {
    Name = "${lower(var.env)}-app-${element(var.azs, count.index)}"
  }
}


resource "aws_subnet" "db" {
  vpc_id                  = "${data.terraform_remote_state.remote_dev_vpc.vpc_id}"
  cidr_block              = "${element(split(",", var.db_subnets_cidr), count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  count                   = "${length(split(",", var.db_subnets_cidr))}"

  tags {
    Name = "${lower(var.env)}-db-${element(var.azs, count.index)}"
  }
}

resource "aws_subnet" "spare" {
  vpc_id                  = "${data.terraform_remote_state.remote_dev_vpc.vpc_id}"
  cidr_block              = "${element(split(",", var.spare_subnets_cidr), count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  count                   = "${length(split(",", var.spare_subnets_cidr))}"

  tags {
    Name = "${lower(var.env)}-spare-${element(var.azs, count.index)}"
  }
}
