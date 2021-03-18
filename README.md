# VPC & Bastion Terraform
This is a sample Terraform project that uses 2 modules to create a
VPC and a bastion host to use in the VPC.

## Modules
This project uses the following modules:

- [VPC](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
- [Bastion](https://registry.terraform.io/modules/umotif-public/bastion/aws/latest)

There are other configurations you can setup when using these modules.

## Files
- [bastion.tf](./bastion.tf). This is the file containing bastion specific configuration. It creates an EC2 instance and sets the public RSA key to access it.
- [main.tf](./main.tf). This is the main file that will setup the VPC itself.
- [outputs.tf](./outputs.tf). This file contains the output that will be displayed after terraform finishes provisioning resources.
- [variables.tf](./variables.tf). This file contains the variables needed for terraform to setup the VPC and Bastion Host. Changes are needed here to reflect your team number.
- [version.tf](./versions.tf). This files host the version of AWS and Terraform needed.
- [terraform.tfstate](./terraform.tfstate). This is your terraform state file. It gets created after terraform is ran and contains the state of your provisioned resources. Do NOT delete it!!! For CI/CD purposes, you should store this file safely in S3 or use Terraform Cloud.

## Usage
To run this example you need to setup the AWS access key and secret key in the env. variable before applying terraform: 
```
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
$ terraform init
$ terraform plan
$ terraform apply
```

## Inputs
| Variable      | Description          | Default     | Change Default
| ------------- | -------------------- |-------------|---------------
| aws_region    | AWS Region           | us-west-2   |  
| public_key    | Public RSA Key to access the Bastion Host | ssh-rsa xxxxxxxxx MyKeyName | Enter your SSH Key
| bastion_prefix| The bastion prefix   | Bastion-TeamX | Change x for team #
| vpc_name      | The name of your VPC | team0-vpc   | Use your team #
| vpc_cidr      | Your VPC CIDR range  | 10.x.0.0/16 | Change x for team #
| aws_azs       | VPC AZ for the region| ["us-west-2a", "us-west-2b", "us-west-2c"]   | 
| aws_private_subnet_cidr | CIDR for your private subnet| ["10.x.1.0/24", "10.x.2.0/24", "10.x.3.0/24"]  | Change x for team # 
| aws_public_subnet_cidr | CIDR for your public subnet| ["10.x.101.0/24", "10.x.102.0/24", "10.x.103.0/24"]  | Change x for team #
| resource_tags | The tags use for all resources | [TEAM:"X",ENV:"QA"] | Change X for your team #

Change any variables in the [variables.tf](./variables.tf) file for your team number

## Outputs
Please look at [outputs.tf](./outputs.tf)

## Key Pair
If you need information about creating a key pair, here are some links to help you
- [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
- [http://www.dowdandassociates.com/blog/content/howto-create-an-amazon-ec2-key-pair-using-the-aws-cli/](http://www.dowdandassociates.com/blog/content/howto-create-an-amazon-ec2-key-pair-using-the-aws-cli/)
- [https://mediatemple.net/community/products/aws/115000309483/creating-and-using-ssh-keys-for-aws](https://mediatemple.net/community/products/aws/115000309483/creating-and-using-ssh-keys-for-aws)
- [https://serverfault.com/questions/706336/how-to-get-a-pem-file-from-ssh-key-pair](https://serverfault.com/questions/706336/how-to-get-a-pem-file-from-ssh-key-pair)

## Bastion
After all the resources are provisioned, you can see the public IP created as the bastion host. Unfortunately, there is no output to display this resource. You'll need to get it using the AWS Console. However, there is a conf. in [bastion.tf](./bastion.tf) that can setup a DNS name for your bastion host if you have a domain name setup in Rout53.
