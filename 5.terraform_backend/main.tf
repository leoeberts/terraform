resource "aws_security_group" "example" {
  name_prefix = "terraform-test-"
  description = "Example security group for testing Terraform state locking"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-test-sg"
  }
}

resource "time_sleep" "wait_for_10s" {
  create_duration = "10s"
}
