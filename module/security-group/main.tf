##################################################################################################################################
#                                                  Security Group
##################################################################################################################################

#Security Group for EC2 instance

resource "aws_security_group" "Face-Recognition-SG" {
  name = "Face-Recognition-SG"
  vpc_id = var.vpc-id
  ingress {
    from_port = var.HTTPS-Port
    to_port = var.HTTPS-Port
    protocol = "tcp"
    cidr_blocks = [var.anywhere-cidr]
    description = "Ingress HTTPS connection from anywhere"
  }
  ingress {
    from_port = var.SSH-Port
    to_port = var.SSH-Port
    protocol = "tcp"
    cidr_blocks = [var.anywhere-cidr]
    description = "Ingress SSH connection from anywhere"
  }
  ingress {
    from_port = var.Application-port
    to_port = var.Application-port
    protocol = "tcp"
    cidr_blocks = [var.anywhere-cidr]
    description = "Ingress docker port connection from anywhere"
  }
  ingress {
    from_port = var.from-port-node-to-cluster
    to_port = var.to-port-node-to-cluster
    protocol = "tcp"
    cidr_blocks = [var.anywhere-cidr]
    description = "Ingress Node to Cluster"
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.anywhere-cidr]
  }
  tags = {
    Name = "Face-Recognition-SG"
    Project = "Face Recognition"
  }
}