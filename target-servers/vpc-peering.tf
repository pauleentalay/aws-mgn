resource "aws_vpc_peering_connection" "source_to_target_vpc_con" {
  vpc_id      = aws_vpc.migrated_resources_vpc.id
  peer_vpc_id = data.aws_vpc.source_vpc.id
  auto_accept = true

  tags = {
    Name    = "source-to-target-vpc-con"
    Project = "Quokka-migration"
  }
}