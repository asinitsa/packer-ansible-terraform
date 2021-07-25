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
  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "echo Installing Redis",
      "sleep 30",
      "sudo apt-get update",
      "sudo apt-get install -y redis-server",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }
}

