provider "aws" {
  region = "ap-south-1"
}

# 1. WSL se connect karne ke liye SSH Key Pair
resource "aws_key_pair" "rishi_key" {
  key_name   = "rishi-aws-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# 2. Security Group Ports (80, 22, 5000)
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

# 3. AWS Instance with Key Pair
resource "aws_instance" "rishi_server" {
  ami           = "ami-007020fd9c84e18c7"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.rishi_key.key_name
  security_groups = [aws_security_group.rishi_sg.name]

  tags = {
    Name = "Rishi-DevOps-3Tier-Server"
  }
}

output "instance_public_ip" {
  value = aws_instance.rishi_server.public_ip
}
