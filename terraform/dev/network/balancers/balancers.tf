resource "aws_elb" "elb1" {
    name                        = "DEV11"
    subnets                     = ["data.terraform_remote_state.remote_dev_subnets.app_subnet"]
    security_groups             = ["${data.terraform_remote_state.remote_dev_secgroups.default}"]
    instances                   = ["${data.terraform_remote_state.remote_dev_core_nginx.id}"]
    cross_zone_load_balancing   = true
    idle_timeout                = 60
    connection_draining         = true
    connection_draining_timeout = 30
    internal                    = true

    listener {
        instance_port      = 80
        instance_protocol  = "http"
        lb_port            = 80
        lb_protocol        = "http"
        ssl_certificate_id = ""
    }

    health_check {
        healthy_threshold   = 10
        unhealthy_threshold = 2
        interval            = 10
        target              = "HTTP:80/auth/api/version"
        timeout             = 8
    }

    tags {
    }
}
