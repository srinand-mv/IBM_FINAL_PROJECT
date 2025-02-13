resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "MainVPC"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = "AppSubnet"
  }
}

resource "aws_security_group" "app_sg" {
  vpc_id = aws_vpc.main.id

  # Allow SSH access (Change "0.0.0.0/0" to your IP for security)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP access (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP access for app (port 8081)
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP access for app (port 8082)
  ingress {
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AppSecurityGroup"
  }
}

resource "aws_instance" "app_server" {
  ami                         = "ami-00c97da679c04f4a0"  # Update for correct region
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.app_sg.id]  # Attach Security Group

  tags = {
    Name = "AppServer"
  }
}

