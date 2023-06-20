resource "aws_internet_gateway" "igw_a" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = upper("custom_internet_gw")
  }
  depends_on = [
    aws_vpc.custom_vpc
  ]
}


resource "aws_route_table" "routea" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_a.id
  }

  tags = {
    Name = upper("custom_route_table")
  }

  depends_on = [
    aws_vpc.custom_vpc,
    aws_internet_gateway.igw_a
  ]
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subneta.id
  route_table_id = aws_route_table.routea.id
  depends_on = [
    aws_subnet.public_subneta,
    aws_route_table.routea
  ]
}
