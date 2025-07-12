provider "aws" {
  region  = "eu-central-1"
  profile = "terraform-study"
}

resource "aws_instance" "web" {
  ami           = "ami-092ff8e60e2d51e19"
  instance_type = "t2.micro"
}
