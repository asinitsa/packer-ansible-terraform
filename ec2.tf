resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.latest-packer-ami.image_id
  associate_public_ip_address = false
  availability_zone           = "${var.region}a"
  disable_api_termination     = "false"
  iam_instance_profile        = aws_iam_instance_profile.packer.name
  instance_type               = "t3.small"
  key_name                    = aws_key_pair.deploy.key_name
  subnet_id                   = module.vpc.private_subnets[0]
  monitoring                  = false

  vpc_security_group_ids = [aws_security_group.bastion.id]
  tags = {
    Name    = "bastion-instance"
    Ansible = "true"
  }
}