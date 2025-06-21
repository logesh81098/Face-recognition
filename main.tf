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


module "keypair" {
  source = "./module/keypair"
}


module "ec2-instance" {
  source = "./module/ec2-instance"
  subnet-id = module.vpc.subnet-1
  security-group = module.security-group.security-group
  keypair = module.keypair.keyname
  Face-Recognition-EC2-Instance-Profile = module.iam.Face-Recognition-EC2-Instance-Profile
}

module "launch-template" {
  source = "./module/launch-template"
  key-pair = module.keypair.keyname
  security-group = module.security-group.security-group
  subnet-1 = module.vpc.subnet-1
}