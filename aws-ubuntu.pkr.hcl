variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "ubuntu-20-04-ami" {
  type    = string
  default = "ami-0bdbe51a2e8070ff2"
}



packer {
  required_plugins {
    amazon = {
      version = ">= 1.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "{{timestamp}}"
  instance_type = "t3.micro"
  region        = "${var.region}"
  source_ami    = "${var.ubuntu-20-04-ami}"
  ssh_username  = "ubuntu"
  tags = {
    Name = "learn-packer-linux-aws"
  }
}

build {
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "ansible" {
    playbook_file = "./ansible.yml"
  }
}

