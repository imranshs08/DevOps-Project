output "EIP-Web-Server" {
  value = aws_instance.web.public_ip
}

output "Private-IP" {
  value = aws_instance.web.private_ip
}