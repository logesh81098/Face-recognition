module "s3" {
  source = "./module/s3"
  Rekognition-Faceprints-arn = module.lambda-function.Rekognition-Faceprints-arn
}

module "iam" {
  source = "./module/iam"
}

module "lambda-function" {
  source = "./module/lambda-function"
  rekognition-role-arn = module.iam.rekognition-role-arn
  rekognition-faceprints-role = module.iam.rekognition-faceprints-role
  source-s3-bucket-arn = module.s3.source-s3-bucket-arn
}

module "dynamodb" {
  source = "./module/dynamo-db"
}

module "vpc" {
  source = "./module/vpc"
}

module "security-group" {
  source = "./module/security-group"
  vpc-id = module.vpc.vpc-id
}