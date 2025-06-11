##################################################################################################################################
#                                                      Keypair
##################################################################################################################################

#Keypair for EC2 instance

resource "tls_private_key" "face-recognition" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "face-recognition-keypair" {
  public_key = tls_private_key.face-recognition.public_key_openssh
  key_name = "Face-Recognition-Keypair"
}

resource "local_file" "face-recognition-private-key" {
  filename = "Face-Recognition-private-key"
  content = tls_private_key.face-recognition.private_key_openssh
}