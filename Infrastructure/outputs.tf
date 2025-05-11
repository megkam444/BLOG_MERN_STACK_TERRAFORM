output "aws_instance_public_ip" {
  value = aws_instance.myweb.public_ip
}
output "private_key_path" {
  value = local_file.private_key_pem.filename
}

output "public_key" {
  value = tls_private_key.ssh_key.public_key_openssh
}
