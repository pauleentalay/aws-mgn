
##ROUTE TABLE##
resource "aws_route_table" "application_rt" {
  vpc_id = aws_vpc.migrated_resources_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.migrated_resources_igw.id
  }

  tags = {
    Name    = "application-rt"
    Project = "Quokka-migration"
  }
}

resource "aws_route_table" "data_centre_rt" {
  vpc_id = aws_vpc.migrated_resources_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.migrated_resources_nat_gw.id
  }

  tags = {
    Name    = "migrated-resources-rt"
    Project = "Quokka-migration"
  }
}

resource "aws_route_table" "staging_area_rt" {
  vpc_id = aws_vpc.migrated_resources_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.migrated_resources_nat_gw.id
  }

  tags = {
    Name    = "staging-area-rt"
    Project = "Quokka-migration"
  }
}

resource "aws_route_table" "on_prem_source_peer_rt" {
  vpc_id = data.aws_vpc.source_vpc.id

  route {
    cidr_block                 = aws_vpc.migrated_resources_vpc.cidr_block
    vpc_peering_connection_id  = aws_vpc_peering_connection.source_to_target_vpc_con.id
  }

  tags = {
    "Name" = "on-prem-source-peer-rt",
    "Project" = "Quokka-migration"
  }
}
resource "aws_route_table" "migrated_resources_peer_rt" {
  vpc_id = aws_vpc.migrated_resources_vpc.id

  route {
    cidr_block                 = data.aws_vpc.source_vpc.cidr_block
    vpc_peering_connection_id  = aws_vpc_peering_connection.source_to_target_vpc_con.id
  }

  tags = {
    "Name" = "migrated-resources-peer-rt",
    "Project" = "Quokka-migration"
  }
}

### ROUTE TABLE ASSOCIATION ###
resource "aws_route_table_association" "application_rt_assoc" {
  subnet_id      = aws_subnet.application_subnet.id
  route_table_id = aws_route_table.application_rt.id
}

resource "aws_route_table_association" "data_centre_rt_assoc" {
  subnet_id      = aws_subnet.data_centre_subnet.id
  route_table_id = aws_route_table.data_centre_rt.id
}

resource "aws_route_table_association" "staging_area_rt_assoc" {
  subnet_id      = aws_subnet.staging_area_subnet.id
  route_table_id = aws_route_table.staging_area_rt.id
}