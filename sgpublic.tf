################################ Creating Security Group for Instances Launched on Public Subnet #############################################

variable "myports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22, 80, 443]
}

resource "aws_security_group" "publicsubnetsg" {
  name        = "allow CUSTOM PORTS OPENED for Server Launced in Public Subnet"
  description = "allow CUSTOM PORTS OPENED for Server Launced in Public Subnet"
  vpc_id      = aws_vpc.custom_vpc.id

  dynamic "ingress" {
    for_each = var.myports
    iterator = port
    content {
      description = "ALLOW SSH ON PUBLIC SUBNET"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "CUSTOM_SG_PUBLIC_INSTANCE"
  }
}
