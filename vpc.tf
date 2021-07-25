module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.2.0"
  name            = "packer-vpc"
  cidr            = "172.35.0.0/16"
  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = ["172.35.1.0/24", "172.35.2.0/24"]
  public_subnets  = ["172.35.5.0/24", "172.35.6.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

}

