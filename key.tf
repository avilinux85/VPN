# RSA key of size 4096 bits
resource "tls_private_key" "rsa4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "avi-keypair" {
  key_name   = "terra-key"
  public_key = tls_private_key.rsa4096.public_key_openssh
}

resource "local_file" "privatekey" {
  content  = tls_private_key.rsa4096.private_key_pem
  filename = "avishek_terra_key.pem"
}
