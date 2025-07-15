module "my_ec2_from_github" {
  source = "github.com/leoeberts/terraform/4.modules_workspaces/4.2.using_custom_modules/modules/ec2"
}

module "latest_linux_ami" {
  source = "./modules/ami"
  filter = [
    {
      name   = "name"
      values = ["al*-ami-20*-kernel-6*-x86_64"]
    },
    {
      name   = "architecture"
      values = ["x86_64"]
    },
    {
      name   = "virtualization-type"
      values = ["hvm"]
    }
  ]
}

module "my_ec2_from_local" {
  source        = "./modules/ec2"
  ami           = module.latest_linux_ami.ami.id
  instance_type = "t2.micro"
}
