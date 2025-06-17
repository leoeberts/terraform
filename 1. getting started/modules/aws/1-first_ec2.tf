resource "aws_instance" "first_terraform_ec2" {
    ami = "ami-092ff8e60e2d51e19"
    instance_type = "t2.micro"
    tags = {
        Name = "first_terraform_ec2"
    }
}