output "rekognition-role-arn" {
  value = aws_iam_role.rekognition-collection-id-role.arn
}

output "rekognition-faceprints-role" {
  value = aws_iam_role.faceprints-role.arn
}