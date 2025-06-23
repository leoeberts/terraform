output "public_ip" {
  value = aws_eip.lb.public_ip
}

output "public_address" {
  value = "http://${aws_eip.lb.public_ip}:8080"
}
