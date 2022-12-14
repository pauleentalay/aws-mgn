resource "aws_vpc" "migrated_resources_vpc" {
  cidr_block = "10.168.0.0/16"

  tags = {
    Name    = "migrated-resources-vpc"
    Project = "Quokka-migration"
  }
}