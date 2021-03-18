variable "aws_region" {
  type        = string
  default     = "us-west-2"
  description = "AWS Default region."
}

variable "public_key" {
  type        = string
  default     = "ssh-rsa xxxxxxxxx MyKeyName"
  description = "The public key to access your bastion server"
}

variable "bastion_prefix"{
  type        = string
  default     = "Bastion-TeamX"
  description = "Bastion prefix for the bastion resources"
}

variable "vpc_name"{
  type        = string
  default     = "team0-vpc"
  description = "The name of the VPC" 
}

# Change all .x. with your team number for the vpc CIDR and subnets
variable "vpc_cidr" {
  type        = string
  default     = "10.x.0.0/16"
  description = "CIDR for the VPC"
}

variable "aws_azs" {
  description = "List of az in the specified region"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "aws_private_subnet_cidr" {
  description = "List of internal CIDR ranges for the private subnet"
  type        = list(string)
  default     = ["10.x.1.0/24", "10.x.2.0/24", "10.x.3.0/24"]
}

variable "aws_public_subnet_cidr" {
  description = "List of internal CIDR ranges for the public subnet"
  type        = list(string)
  default     = ["10.x.101.0/24", "10.x.102.0/24", "10.x.103.0/24"]
}


variable "resource_tags" {
  type = object({
    TEAM = string
    ENV  = string
  })
  default = {
    TEAM = "X"
    ENV  = "QA"
  }
}

