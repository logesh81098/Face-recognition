##################################################################################################################################
#                                      Launch Template for EKS Node Group
##################################################################################################################################

#Launch Template for EKS Node Group

resource "aws_launch_template" "eks-node-group" {
  name = "Face-Rekognition-launch-template"
  key_name = var.key-pair
  network_interfaces {
    security_groups = [var.security-group]
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