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