resource "aws_iam_instance_profile" "packer" {
  name_prefix = "packer-"
  role        = aws_iam_role.packer.name
}

resource "aws_iam_role" "packer" {
  name_prefix = "packer-"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "rancher-master-02" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.packer.name
}