##################################################################################################################################
#                                                    S3 Bucket
##################################################################################################################################

#S3 bucket to store source images

resource "aws_s3_bucket" "source-bucket" {
  bucket = "face-rekognition-source-bucket"
  tags = {
    Name = "face-rekognition-source-bucket"
    Project = "Face Recognition"
  }
}


##################################################################################################################################
#                                                S3 to trigger lambda
##################################################################################################################################

#S3 bucket to trigger lambda function for object creation

resource "aws_s3_bucket_notification" "s3-to-trigger-lambda" {
  bucket = aws_s3_bucket.source-bucket.bucket
  lambda_function {
    lambda_function_arn = var.Rekognition-Faceprints-arn
    events = ["s3:ObjectCreated:*"]
  }
  
}