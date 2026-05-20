provider "aws" {
  region = "ap-south-1" # Mumbai Region
}

# Web aur SSH traffic ke liye Security Group
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Mumbai me chalne wala t3.micro EC2 Instance
resource "aws_instance" "rishi_server" {
  ami           = "ami-007020fd9c84e18c7" # Ubuntu Server 24.04 LTS (ap-south-1)
  instance_type = "t3.micro"              # Mumbai free tier eligible
  security_groups = [aws_security_group.rishi_sg.name]

  tags = {
    Name = "Rishi-DevOps-3Tier-Server"
  }
}

output "instance_public_ip" {
  value = aws_instance.rishi_server.public_ip
}
