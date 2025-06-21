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

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.face-rekognition-cluster.name
}


##################################################################################################################################
#                                         Security Group rule for EKS Node Group
##################################################################################################################################

#Security Group rule for EKS Node Group

resource "aws_security_group_rule" "EKS-SG" {
  type = "ingress"
  from_port = var.from-port
  to_port = var.to-port
  protocol = "tcp"
  security_group_id = var.security-groups
  source_security_group_id = data.aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
  description = "Allow EKS control plane to access worker nodes"
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

