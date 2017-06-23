module "nerdearla" { 
    source = "../../../../modules/core/nginx" 
    region = "us-east-1"
    root_volume_size = "10"
    amiid = "ami-80861296"
    config_key = ""
    instancetype = "t2.micro"
    iamprofile = ""
    env = "Dev"
    secgroups = ["${data.terraform_remote_state.remote_dev_secgroups.all_ports}"]
    instancesnum = ""
    subnet = ["${data.terraform_remote_state.remote_dev_subnets.app_subnet}"]
    azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
