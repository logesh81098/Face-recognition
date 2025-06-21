##################################################################################################################################
#                                      Launch Template for EKS Node Group
##################################################################################################################################

#Launch Template for EKS Node Group

resource "aws_launch_template" "eks-node-group" {
  name = "Face-Rekognition-launch-template"
  image_id = var.ami-id
  instance_type = var.instance-type
  key_name = var.key-pair
  network_interfaces {
    security_groups = [var.security-group]
    subnet_id = var.subnet-1
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Face Rekognition Node Group"
      Project = "Face Recognition"
    }
  }
  tags = {
    Name = "Face Rekognition launch template"
    Project = "Face Recognition"
  }
}