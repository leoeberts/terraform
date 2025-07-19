resource "aws_instance" "web" {
  ami           = data.aws_ami.latest_linux.id
  instance_type = "t2.micro"
}

resource "time_sleep" "wait_20s" {
  create_duration = "20s"
}
