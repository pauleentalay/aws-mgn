resource "aws_security_group" "onprem_internet_sg" {
  name        = "onprem-internet-sg"
  description = "SG with internet access"
  vpc_id      = data.aws_vpc.source_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Access to internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Access to internet"
    from_port   = 443
    to_port     = 443
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

resource "aws_security_group" "onprem_db_sg" {
  name        = "onprem-db-sg"
  description = "SG with internet access"
  vpc_id      = data.aws_vpc.source_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Access of WebApp server"
    from_port   = 5432
    to_port     = 5432
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

resource "aws_instance" "onprem_internet_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  key_name               = "ta-ec2"
  instance_type          = "t3.micro"
  subnet_id              = data.aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.onprem_internet_sg.id]
  user_data              = "${path.module}/user_data_1.sh"

  tags = {
    Name    = "onprem-internet-ec2"
    Project = var.project_name
  }
}

resource "aws_instance" "onprem_db_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  key_name               = "ta-ec2"
  instance_type          = "t3.micro"
  subnet_id              = data.aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.onprem_db_sg.id]
  user_data              = "${path.module}/user_data_2.sh"

  tags = {
    Name    = "onprem-db-ec2"
    Project = var.project_name
  }
}