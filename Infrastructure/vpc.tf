resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Nane = "my_vpc"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igw"
  }
}
resource "aws_subnet" "pub_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "pub-subnet"
  }

}
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.16.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "private_subnet"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "public_rt"
  }
}
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_ngw.id
  }


}

resource "aws_eip" "nat_ip" {
  domain = "vpc"

}
resource "aws_nat_gateway" "my_ngw" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.pub_subnet.id
  tags = {
    Name = "my_ngw"
  }

}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.public_rt.id

}
resource "aws_route_table_association" "private_rt_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id

}

resource "aws_security_group" "mysg" {
  name        = "mysg"
  description = "allow http,https & ssh"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    description = "http from vpc"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    "Name" = "mysg"
  }

}

