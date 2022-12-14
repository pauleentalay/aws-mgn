
##VPC Internet gateway
resource "aws_internet_gateway" "migrated_resources_igw" {
  vpc_id = aws_vpc.migrated_resources_vpc.id

  tags = {
    Name    = "migrated-resources-igw"
    Project = "Quokka-migration"
  }
}


#AWS_EIP
resource "aws_eip" "migrated_resources_nat_eip" {
  vpc = true

  tags = {
    Name    = "migrated-resources-nat-eip"
    Project = "Quokka-migration"
  }
}

##Public NAT gateway


resource "aws_nat_gateway" "migrated_resources_nat_gw" {
  allocation_id = aws_eip.migrated_resources_nat_eip.id
  subnet_id     = aws_subnet.application_subnet.id

  tags = {
    Name    = "migrated-resources-nat-gw"
    Project = "Quokka-migration"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.migrated_resources_igw]
}