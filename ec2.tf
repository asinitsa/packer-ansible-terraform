resource "aws_instance" "packer" {
  ami                         = data.aws_ami.latest-packer-ami.image_id
  associate_public_ip_address = false
  availability_zone           = "${var.region}a"
  disable_api_termination     = "false"
  iam_instance_profile        = aws_iam_instance_profile.packer.name
  instance_type               = "t3.small"
  key_name                    = aws_key_pair.deploy.key_name
  subnet_id                   = module.vpc.private_subnets[0]
  monitoring                  = false

  vpc_security_group_ids = [module.vpc.default_security_group_id]
  tags = {
    Name    = "learn-packer-instance"
    Ansible = "true"
  }
}