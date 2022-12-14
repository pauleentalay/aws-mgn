data "aws_vpc" "source_vpc" {
  filter {
    name   = "tag:Project"
    values = [var.vpc_name]
  }
}