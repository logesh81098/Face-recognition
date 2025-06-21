output "rekognition-role-arn" {
  value = aws_iam_role.rekognition-collection-id-role.arn
}

output "rekognition-faceprints-role" {
  value = aws_iam_role.faceprints-role.arn
}

output "Face-Recognition-EC2-Instance-Profile" {
  value = aws_iam_instance_profile.Face-Recognition-EC2-Instance-Profile.name
}

output "Face-Rekognition-EKS-Cluster-Role-ARN" {
  value = aws_iam_role.eks-cluster-role.arn
}

output "Face-Rekognition-EKS-Worker-Node-Role-arn" {
  value = aws_iam_role.eks-worker-node.arn
}