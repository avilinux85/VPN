resource "aws_security_group" "priv_sg" {
  name        = "ALLOW SSH FROM BASTION HOST"
  description = "ALLOW SSH FROM BASTION HOST"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
    description = "ENABLING PORT 22 only from BASTION HOST"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [
      "${aws_security_group.publicsubnetsg.id}"
    ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "CUSTOM_SG_PRIVATE_INSTANCE"
  }
  depends_on = [
    aws_security_group.publicsubnetsg
  ]
}
