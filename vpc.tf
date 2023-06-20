resource "aws_vpc" "custom_vpc" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = upper("custom_vpc_mumbai")
  }
}
