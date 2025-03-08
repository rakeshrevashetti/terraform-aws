resource "aws_instance" "backend_server" {
  ami           = "ami-0c55b159cbfafe1f0"  # Change this to a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = "my-key-pair"  # Make sure you have an existing AWS key pair

  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "BackendServer"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "backend-sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH (change for security)
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow backend API access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

