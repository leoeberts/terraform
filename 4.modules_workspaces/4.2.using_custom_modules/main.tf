module "my_ec2_from_github" {
  source = "github.com/leoeberts/terraform/4.modules_workspaces/4.2.using_custom_modules/modules/ec2"
}

module "latest_linux_ami" {
  source = "./modules/ami"
  providers = {
    aws.frankfurt = aws
    aws.ireland   = aws.ireland
  }

  filter = var.ami_filter
}

module "my_ec2_from_local_frankfurt" {
  source = "./modules/ec2"
  providers = {
    aws = aws
  }

  ami           = module.latest_linux_ami.ami.frankfurt.id
  instance_type = "t2.micro"
}

module "my_ec2_from_local_ireland" {
  source = "./modules/ec2"
  providers = {
    aws = aws.ireland
  }

  ami           = module.latest_linux_ami.ami.ireland.id
  instance_type = "t2.micro"
}
