
resource "aws_instance" "depends_on_bucket" {
  ami           = data.aws_ami.latest_linux.id
  instance_type = "t2.micro"

  tags = {
    Name = "terraform_depends_on_bucket"
  }

  depends_on = [aws_s3_bucket.bucket]
}

resource "aws_s3_bucket" "bucket" {
  bucket = "1321-terraform-depends-on-bucket"
}
