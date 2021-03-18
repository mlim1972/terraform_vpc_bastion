provider "aws" {
  region = var.aws_region
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

resource "aws_eip" "nat" {
  count = 1

  vpc = true
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name

  cidr = var.vpc_cidr

  azs             = var.aws_azs
  private_subnets = var.aws_private_subnet_cidr
  public_subnets  = var.aws_public_subnet_cidr
  
  # Single NAT for all AZ
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
  
  reuse_nat_ips       = true               # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids = aws_eip.nat.*.id   # <= IPs specified here as input to the module

  # Tags
  public_subnet_tags = var.resource_tags
  private_subnet_tags = var.resource_tags
  tags = var.resource_tags
  vpc_tags = var.resource_tags

  # # VPC endpoint for S3
  # # Note - S3 Interface type support is only available on AWS provider 3.10 and later
  # enable_s3_endpoint              = true
  # s3_endpoint_type                = "Interface"
  # s3_endpoint_private_dns_enabled = false
  # s3_endpoint_security_group_ids  = [data.aws_security_group.default.id]
}