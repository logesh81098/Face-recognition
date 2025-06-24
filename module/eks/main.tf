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

resource "aws_eks_node_group" "Face-rekognition-node-group" {
  cluster_name = aws_eks_cluster.face-rekognition-cluster.id
  node_group_name = "Face-Rekognition-Node-Group"
  node_role_arn = var.node-group-role-arn
  scaling_config {
    max_size = "2"
    desired_size = "1"
    min_size = "1"
  }
  subnet_ids = [ var.subnet-1, var.subnet-2 ]
  instance_types = ["t3.medium"]
  launch_template {
    id = var.launch-template-id
    version = "$Latest"
  }
  tags = {
    Name = "Face-Rekognition-NodeGroup"
    Project = "Face Recognition"
  }

}