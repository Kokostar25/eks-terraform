module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.11.3"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"
  azs = slice(data.aws_availability_zones.available.names, 0,2)
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}