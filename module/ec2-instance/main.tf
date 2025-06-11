##################################################################################################################################
#                                                     EC2 instance
##################################################################################################################################

#EC2 instance

resource "aws_instance" "Face-recognition-server" {
  ami = var.ami-id
  instance_type = var.instance-type
  key_name = var.keypair
  subnet_id = var.subnet-id
  security_groups = [var.security-group]
  tags = {
    Name = "Face-Recognition-Server"
    Project = "Face Recognition"
  }
}