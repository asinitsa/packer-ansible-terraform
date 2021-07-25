terraform {
  required_version = ">= 0.15"
  required_providers {}
}

provider "aws" {
  region = "eu-central-1"
}

locals { }

resource "tls_private_key" "deploy" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deploy" {
  key_name   = "deploy-539175108451"
  public_key = tls_private_key.deploy.public_key_openssh
}

data "aws_ami" "latest-packer-ami" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "tag:Name"
    values = ["learn-packer-linux-aws"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}