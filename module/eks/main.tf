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

resource "aws_eks_node_group" "face-rekognition-nodegroup" {
  cluster_name = aws_eks_cluster.face-rekognition-cluster.id
  node_group_name = "Face-Rekognition-Nodegroup"
  node_role_arn = var.nodegroup-role
  subnet_ids = [ var.subnet-1, var.subnet-2 ]
  launch_template {
    id = var.launch-template-id
    version = "$Latest"
  }
  scaling_config {
    desired_size = 1
    max_size = 1 
    min_size = 1
  }
  tags = {
    Name = "Face-Rekognition-Nodegroup"
    Project = "Face Recognition"
  }
}