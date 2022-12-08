data "aws_vpc" "source_vpc" {
  filter {
    name   = "tag:Project"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "public_subnet" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_name]
  }
}

data "aws_subnet" "private_subnet" {
  filter {
    name   = "tag:Name"
    values = [var.private_subnet_name]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = [var.ubuntu_version]
  }
  owners = [var.ami_owner]
}