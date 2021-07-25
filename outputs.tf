output "latest-packer-ami-id" {
  value = data.aws_ami.latest-packer-ami.image_id
}