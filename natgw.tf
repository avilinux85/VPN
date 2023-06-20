resource "aws_eip" "eip_ng" {
  vpc = "true"
}

resource "aws_nat_gateway" "nat_gwa" {
  allocation_id = aws_eip.eip_ng.id
  subnet_id     = aws_subnet.public_subneta.id

  tags = {
    Name = upper("custom_nat_gateway")
  }
  depends_on = [
    aws_internet_gateway.igw_a,
    aws_eip.eip_ng,
    aws_subnet.public_subneta
  ]
}


resource "aws_route_table" "routetablenatgw" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gwa.id
  }

  tags = {
    Name = upper("ROUTE_TABLE_NATGW")
  }

  depends_on = [
    aws_vpc.custom_vpc,
    aws_nat_gateway.nat_gwa
  ]
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private_subneta.id
  route_table_id = aws_route_table.routetablenatgw.id
  depends_on = [
    aws_subnet.private_subneta,
    aws_route_table.routetablenatgw
  ]
}
