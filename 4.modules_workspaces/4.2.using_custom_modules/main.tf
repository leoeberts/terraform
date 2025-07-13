module "my_ec2_from_github" {
  source = "github.com/leoeberts/terraform/4.modules_workspaces/4.2.using_custom_modules/modules/ec2"
}

module "my_ec2_from_local" {
  source        = "./modules/ec2"
  ami           = "ami-092ff8e60e2d51e19"
  instance_type = "t2.micro"
}
