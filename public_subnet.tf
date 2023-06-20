resource "aws_subnet" "public_subneta" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = upper("custom_public_subnet")
  }
  depends_on = [
    aws_vpc.custom_vpc
  ]
}
