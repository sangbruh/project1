provider "aws" {
  region = "eu-north-1"
}

resource "aws_key_pair" "netflix-clone-key" {
  key_name   = "netflix-clone-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "netflix-clone-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tfkey"
}

resource "aws_security_group" "TF_SG" {
  name        = "security group using Terraform"
  description = "security group using Terraform"
  vpc_id      = "vpc-0fb46171d561011c8"

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "TF_SG"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0fe8bec493a81c7da"
  instance_type = "t3.micro"
  key_name = "netflix-clone-key"
  security_groups = [aws_security_group.TF_SG.name]
  ebs_block_device {
    volume_size = 25
    device_name = "/dev/sda1"
  }

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_eip" "elasticip" {
  instance = aws_instance.web.id
}