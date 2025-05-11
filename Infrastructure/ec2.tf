resource "aws_instance" "myweb" {
  ami                    = var.ami_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id              = aws_subnet.pub_subnet.id
  key_name               = aws_key_pair.generated_key.key_name
  tags = {
    "Name" = "myweb"
  }
}


