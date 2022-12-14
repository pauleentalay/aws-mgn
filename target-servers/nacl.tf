resource "aws_network_acl" "application_data_nacl" {
  vpc_id     = aws_vpc.migrated_resources_vpc.id
  subnet_ids = [aws_subnet.application_subnet.id, aws_subnet.data_centre_subnet.id]

  egress {
    protocol   = "-1"
    rule_no    = 10
    action     = "deny"
    cidr_block = data.aws_vpc.source_vpc.cidr_block
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "deny"
    cidr_block = data.aws_vpc.source_vpc.cidr_block
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name    = "application-data-nacl"
    Project = "Quokka-migration"
  }
}
