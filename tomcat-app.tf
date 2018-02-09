provider "aws" {
  region                  = "us-west-2"
  profile                 = "terraform-user"
}

data "aws_availability_zones" "available" {}

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "1.12.0"

    name = "tomcat"
    cidr = "${var.vpc_cidr}"
    azs = ["${data.aws_availability_zones.available.names[0]}"]
    public_subnets = ["${var.public_subnet_cidr}"]
    enable_dns_hostnames = true

    tags = {
        Terraform = "True"
    }
}

module "sg-elb" {
  source = "terraform-aws-modules/security-group/aws"
  version = "1.6.0"

  name = "Tomcat_ELB"
  description = "Tomcat ELB Security Group"
  vpc_id = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      description = "Tomcat Port"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port = 0
      to_port = 65535
      protocol = "all"
      description = "All egress"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Name = "Tomcat Server"
    Terraform = "True"
  }
}

module "sg" {
    source = "terraform-aws-modules/security-group/aws"
    version = "1.6.0"

    name = "tomcat-sg"
    description = "Tomcat Security Group"
    vpc_id = "${module.vpc.vpc_id}"

    ingress_with_cidr_blocks = [
        {
            from_port = 8080
            to_port = 8080
            protocol = "tcp"
            description = "Tomcat Port"
            cidr_blocks = "${var.public_subnet_cidr}"
        },
        {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            description = "Ssh Port"
            cidr_blocks = "0.0.0.0/0"
        }
    ]

    egress_with_cidr_blocks = [
        {
            from_port = 0
            to_port = 65535
            protocol = "all"
            description = "All egress"
            cidr_blocks = "0.0.0.0/0"
        }
    ]

    tags = {
        Name = "Tomcat Server"
        Terraform = "True"
    }
}

resource "aws_instance" "tomcat" {
    
    ami = "${lookup(var.amis, var.region)}"
    instance_type = "${var.instance_type}"
    subnet_id = "${module.vpc.public_subnets[0]}"
    vpc_security_group_ids = ["${module.sg.this_security_group_id}"]

    count = 1
    key_name = "${var.key_pair}"
    monitoring = false
    associate_public_ip_address = true

    root_block_device = {
        volume_size = 20
    }

    provisioner "file" {
        source = "chef"
        destination = "/home/ec2-user/chef"

        connection {
            type = "ssh"
            user = "ec2-user"
            private_key = "${file( "${pathexpand( "${var.private_key_path}" )}" )}"
            timeout = "60s"
        }
    }

    provisioner "remote-exec" {
        inline = [
            "curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 13.6.4",            
            "sudo chef-solo -c $PWD/chef/solo.rb -j $PWD/chef/solo.json"
        ]
        connection {
            type = "ssh"
            user = "ec2-user"
            private_key = "${file( "${pathexpand( "${var.private_key_path}" )}" )}"
            timeout = "60s"
        }
    }

    tags = {
        Name = "Tomcat Server"
        Terraform = "True"
    }

    volume_tags = {
        Name = "Tomcat Server"
        Terraform = "True"
    }
}


###########Definicion del Elastic Load Balancer##############
resource "aws_elb" "prodapp-elb" {
  name               = "ATApp-terraform-elb"
  #availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  security_groups = ["${module.sg-elb.this_security_group_id}"]
  subnets = ["${module.vpc.public_subnets[0]}"]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "tcp:8080"
    interval            = 30
  }

  instances = ["${aws_instance.tomcat.id}"]

  tags {
    Name = "ATApp-terraform-elb"
    Environment = "Production"
  }
}
