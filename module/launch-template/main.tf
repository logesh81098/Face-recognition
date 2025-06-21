##################################################################################################################################
#                                      Launch Template for EKS Node Group
##################################################################################################################################

#Launch Template for EKS Node Group

resource "aws_launch_template" "eks-node-group" {
  name           = "Face-Rekognition-launch-template"
  instance_type  = var.instance-type
  key_name       = var.key-pair
  network_interfaces {
    security_groups = [var.security-group]
  }

  user_data = base64encode(<<-EOF
    MIME-Version: 1.0
    Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

    --==MYBOUNDARY==
    Content-Type: text/x-shellscript; charset="us-ascii"

    #!/bin/bash
    /etc/eks/bootstrap.sh Face-Rekognition-Cluster

    --==MYBOUNDARY==--
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "Face Rekognition Node Group"
      Project = "Face Recognition"
      "eks:cluster-name"                           = "Face-Rekognition-Cluster"   
      "kubernetes.io/cluster/Face-Rekognition-Cluster" = "owned" 

    }
  }

  tags = {
    Name    = "Face Rekognition launch template"
    Project = "Face Recognition"
  }
}
