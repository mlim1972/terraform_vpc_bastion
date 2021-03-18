resource "aws_key_pair" "bastion-key" {
  key_name   = "bastion-key"
  public_key = var.public_key
}

module "bastion" {
  source = "umotif-public/bastion/aws"
  version = "~> 2.0.0"
  region = var.aws_region

  name_prefix = var.bastion_prefix

  vpc_id          = module.vpc.vpc_id
  public_subnets  = flatten([module.vpc.public_subnets])
  private_subnets = flatten([module.vpc.private_subnets])

  ssh_key_name    = "bastion-key"

  # if you have a domain name setup, you can use the command below to 
  # add the Bastion Host in AWS Route53. You need your ZoneId
  #hosted_zone_id = "Zxxxxxxxxxxxxxxxx"

  tags = var.resource_tags
}