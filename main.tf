
variable "region" {
  description = "Región de AWS"
  default     = "us-east-1"
}


provider "aws" {
  region = var.region
}


resource "aws_security_group" "ssh_http_sg" {
  name        = "ssh-http-sg"
  description = "Permitir tráfico SSH y HTTP"

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
    description = "Todo el tráfico de salida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "GrupoSeguridadSSH_HTTP"
  }
}


resource "aws_instance" "mi_instancia" {
  ami           = "ami-0c55b159cbfafe1f0" 
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.ssh_http_sg.id]

  tags = {
    Name = "InstanciaConSeguridad"
  }
}


output "ip_publica" {
  value = aws_instance.mi_instancia.public_ip
}
