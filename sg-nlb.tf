resource "aws_lb" "bastion" {
  name                       = "bastion"
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "bastion-ssh" {
  port        = 22
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "bastion-ssh" {
  target_group_arn = aws_lb_target_group.bastion-ssh.arn
  target_id        = aws_instance.bastion.id
  port             = 22
}

resource "aws_lb_listener" "bastion-ssh" {
  load_balancer_arn = aws_lb.bastion.arn
  port              = "22"
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.bastion-ssh.arn
    type             = "forward"
  }
}

resource "aws_security_group" "bastion" {

  description = "Access to bastion nodes"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Traffic to bastion"
    from_port   = "22"
    protocol    = "tcp"
    self        = "false"
    to_port     = "22"
  }

  ingress {
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "Traffic inside VPC"
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  vpc_id = module.vpc.vpc_id

}