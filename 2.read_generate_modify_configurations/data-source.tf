data "aws_vpc" "selected" { #Get infor from resurces managed outside of TF
  id = "vpc-07026206cc7697c1b"
}

output "vpc_tagscd" {
  value = {
    tags = data.aws_vpc.selected.tags
  }
}
