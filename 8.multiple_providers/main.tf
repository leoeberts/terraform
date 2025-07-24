resource "aws_security_group" "my_sg_1" {
  provider = aws.frankfurt
  name     = "my_sg_1"
}

resource "aws_security_group" "my_sg_2" {
  provider = aws.ireland
  name     = "my_sg_2"
}
