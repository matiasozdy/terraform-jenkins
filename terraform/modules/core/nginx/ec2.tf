provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "nerdearla" {
 
    ami                         = "${var.amiid}"
    count			= "${var.instancesnum}"
    availability_zone           = "${element(var.azs, count.index)}"
    ebs_optimized               = false
    instance_type               = "${var.instancetype}"
    monitoring                  = false
    key_name                    = "${var.config_key}"
    subnet_id      		= "${element(var.subnet, count.index)}"
    vpc_security_group_ids      = ["${var.secgroups}"]
    associate_public_ip_address = false
    source_dest_check           = true
    iam_instance_profile	= "${var.iamprofile}"

    root_block_device {
        volume_type           = "standard"
        volume_size           = "${var.root_volume_size}"
        delete_on_termination = true
    }

    tags {
        "Name" = "${lower(var.env)}-nerdearla${format("%02d",count.index + 1)}"
        "Role" = "Nginx server"
        "Environment" = "${var.env}"
    }

#    provisioner "chef" {
#      environment     = "${var.env}"
#      run_list        = ["nginx"]
#      node_name       = "${lower(var.env)}-nerdearla${format("%02d",count.index + 1)}"
#      server_url      = ""
#      recreate_client = true
#      user_name       = ""
#      user_key        = "${file("")}"
#      version         = ""
#      connection {
#        type = "ssh"
#        user = ""
#        private_key = "${file("")}"
#      }
#    }
provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
    connection {
        host = "${self.public_ip}"
        type = "ssh"
        user = ""
        private_key = "${file("")}"
      }
  

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "/tmp/bootstrap.sh",
    ]
    connection {
        host = "${self.public_ip}"
        type = "ssh"
        user = ""
        private_key = "${file("")}"
      }
  }     
}
