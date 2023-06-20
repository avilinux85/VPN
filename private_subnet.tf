resource "aws_subnet" "private_subneta" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = upper("custom_private_subnet")
  }
  depends_on = [
    aws_vpc.custom_vpc
  ]
}
