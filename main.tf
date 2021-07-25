terraform {
  required_version = ">= 0.15"
  required_providers {}
}

provider "aws" {
  region = "eu-central-1"
}

locals {}

resource "tls_private_key" "deploy" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deploy" {
  key_name   = "deploy-539175108451"
  public_key = tls_private_key.deploy.public_key_openssh
}

resource "aws_ssm_parameter" "packer-key-private" {
  name        = "/packer/ssh/private"
  description = "Private ssh key"
  type        = "SecureString"
  value       = tls_private_key.deploy.private_key_pem
  overwrite   = true
}

resource "aws_ssm_parameter" "packer-key-public" {
  name        = "/packer/ssh/public"
  description = "Public ssh key"
  type        = "SecureString"
  value       = tls_private_key.deploy.public_key_openssh
  overwrite   = true
}

data "aws_ami" "latest-packer-ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "tag:Name"
    values = ["learn-packer-linux-aws"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

