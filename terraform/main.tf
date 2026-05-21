provider "aws" {
  region = "ap-south-1"
}

# Security Group
resource "aws_security_group" "rishi_sg" {
  name        = "rishi-3-tier-sg"
  description = "Allow inbound traffic for 3-tier project"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# AWS Instance
resource "aws_instance" "rishi_server" {
  ami             = "ami-007020fd9c84e18c7"
  instance_type   = "t3.micro"
  key_name        = "project-key" 
  security_groups = [aws_security_group.rishi_sg.name]

  tags = {
    Name = "Rishi-DevOps-3Tier-Server"
  }
}

# Permanent Elastic IP Allocation (Zindagi bhar ke liye fixed IP)
resource "aws_eip" "rishi_static_ip" {
  instance = aws_instance.rishi_server.id
  domain   = "vpc"
}

# Outputs for Jenkins & Review
output "instance_public_ip" {
  value = aws_instance.rishi_server.public_ip
}

output "elastic_ip" {
  value = aws_eip.rishi_static_ip.public_ip
}
