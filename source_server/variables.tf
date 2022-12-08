variable "vpc_name" {
  description = "tag Name of source VPC"
  type        = string
}

variable "public_subnet_name" {
  description = "tag Name of source public subnet"
  type        = string
}

variable "private_subnet_name" {
  description = "tag Name of source private subnet"
  type        = string
}

variable "ubuntu_version" {
  description = "version of ubuntu"
  type        = string
}

variable "ami_owner" {
  description = "ID of AMI owner"
  type        = string
}

variable "project_name" {
  type = string
}