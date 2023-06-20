###   Use this data source to get the ID of a registered AMI for use in other resources.#####
data "aws_ami" "ami_data_private" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "priv" {
  ami                    = data.aws_ami.ami_data_private.id
  instance_type          = "t2.micro"
  key_name               = "terra-key"
  vpc_security_group_ids = [aws_security_group.priv_sg.id]
  subnet_id              = aws_subnet.private_subneta.id
  ebs_block_device {
    device_name           = "/dev/sdk"
    volume_type           = "gp2"
    volume_size           = 1
    delete_on_termination = true
  }
  user_data = <<EOF
  #!/bin/bash
  echo "Starting of User Data Script"
  mkfs.xfs /dev/sdk
  echo "Apache Install, enable and configuration going on"
  yum -y install httpd
  systemctl enable httpd
  systemctl start httpd
  mount /dev/sdk /var/www/html/
  echo "<h1>Hello VF-Cloud World running on Linux from $(hostname -f) on port80</h1>" >> /var/www/html/index.html
  echo '/dev/sdk /var/www/html xfs defaults 0 0' >> /etc/fstab
  EOF
  tags = {
    Name = "INSTANCE_PRIVATESUBNET"
  }
  depends_on = [
    aws_instance.web,
    aws_security_group.priv_sg
  ]
}
