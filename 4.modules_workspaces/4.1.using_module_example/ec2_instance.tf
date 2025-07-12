module "ec2-instance" { #some modules do not require input variables
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"
}
