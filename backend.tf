terraform {
  backend "s3" {
    bucket = "terraform-backend-files-logesh"
    region = "us-east-1"
    key = "face-recognition"
  }
}