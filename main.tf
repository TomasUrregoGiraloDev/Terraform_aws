variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}


provider "aws" {
  region = var.region
}


resource "aws_security_group" "ssh_http_sg" {
  name        = "ssh-http-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SSH_HTTP_SecurityGroup"
  }
}


resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe1f0" 
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.ssh_http_sg.id]

  tags = {
    Name = "InstanceWithSecurity"
  }
}


output "public_ip" {
  value = aws_instance.my_instance.public_ip
}
