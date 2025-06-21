##################################################################################################################################
#                                                EKS Cluster
##################################################################################################################################

#EKS Cluster to deploy docker application

resource "aws_eks_cluster" "face-rekognition-cluster" {
  name = "Face-Rekognition-Cluster"
  role_arn = var.cluster-role
  vpc_config {
    subnet_ids = [ var.subnet-1, var.subnet-2 ]
    security_group_ids = [ var.security-groups ]
  }
  tags = {
    Name = "Face-Rekognition-Cluster"
    Project = "Face Recognition"
  }
}


##################################################################################################################################
#                                                EKS Node Group
##################################################################################################################################

#EKS Node Group to deploy docker application

