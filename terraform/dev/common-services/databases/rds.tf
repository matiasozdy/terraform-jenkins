resource "aws_db_instance" "mysql" {
    identifier                = "dev-mysql"
    allocated_storage         = 5
    storage_type              = "gp2"
    engine                    = "mysql"
    engine_version            = "5.7.11"
    instance_class            = "db.t2.medium"
    name                      = "lamp"
    username                  = "admin"
    password                  = "password"
    port                      = 3306
    publicly_accessible       = false
    availability_zone         = "us-east-1a"
    security_group_names      = []
    vpc_security_group_ids    = ["${data.terraform_remote_state.remote_dev_secgroups.default}"]
    db_subnet_group_name      = ""
    parameter_group_name      = "mysql-57"
    multi_az                  = false
    backup_retention_period   = 1
    backup_window             = "00:20-00:50"
    final_snapshot_identifier = "dev-mysql"
}
