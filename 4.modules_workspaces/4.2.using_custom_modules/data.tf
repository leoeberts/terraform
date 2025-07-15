data "aws_key_pair" "study_key" {
  filter {
    name   = "key-pair-id"
    values = ["key-0ce3c988a890c59fc"]
  }
}

output "study_key" {
  value = {
    id   = data.aws_key_pair.study_key.id
    name = data.aws_key_pair.study_key.key_name
  }
}
