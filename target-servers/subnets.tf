resource "aws_subnet" "application_subnet" {
  vpc_id                  = aws_vpc.migrated_resources_vpc.id
  cidr_block              = "10.168.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "application-subnet"
    Project = "Quokka-migration"
  }
}

resource "aws_subnet" "data_centre_subnet" {
  vpc_id            = aws_vpc.migrated_resources_vpc.id
  cidr_block        = "10.168.10.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name    = "data-centre-subnet"
    Project = "Quokka-migration"
  }
}

resource "aws_subnet" "staging_area_subnet" {
  vpc_id            = aws_vpc.migrated_resources_vpc.id
  cidr_block        = "10.168.100.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name    = "staging-area-subnet"
    Project = "Quokka-migration"
  }
}