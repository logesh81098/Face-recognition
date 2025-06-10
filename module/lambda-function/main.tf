#################################################################################################################################
#                                                         Zip Python file
##################################################################################################################################


data "archive_file" "collection-id" {
  type = "zip"
  source_dir = "module/lambda-function"
  output_path = "module/lambda-function/rekognition-collection-id.zip"
}



#################################################################################################################################
#                                                         Lambda Function
##################################################################################################################################

#Lambda function to create collection id in rekogntion service

resource "aws_lambda_function" "rekognition-collection-id" {
  function_name = "Rekognition-Collection-ID"
  runtime = "python3.8"
  filename = "module/lambda-function/rekognition-collection-id.zip"
  timeout = 20
  handler = "rekognition-collection-id.lambda_handler"
  role = var.rekognition-role-arn
  tags = {
    Name = "Rekognition-Collection-ID"
    Project = "Face Recognition"
  }
}


#################################################################################################################################
#                                                         Zip Python file
##################################################################################################################################

data "archive_file" "faceprints-lambda" {
  type = "zip"
  source_dir = "module/lambda-function"
  output_path = "module/lambda-function/rekognition-faceprints.zip"
}


#################################################################################################################################
#                                                         Lambda Function
##################################################################################################################################

#Lambda function to generate faceprints and store it in DynamoDB table

resource "aws_lambda_function" "rekognition-faceprints" {
  function_name = "Rekognition-Faceprints"
  runtime = "python3.8"
  filename = "module/lambda-function/rekognition-faceprints.zip"
  handler = "rekognition-faceprints.lambda_handle"
  role = var.rekognition-faceprints-role
  timeout = 20
  tags = {
    Name = "Rekognition-Faceprints"
    Project = "Face Recognition"
  }
}


#################################################################################################################################
#                                          Lambda Function Resource Based policy
##################################################################################################################################

#Lambda Function Resource Based policy to make s3 as trigger to lambda

resource "aws_lambda_permission" "s3-trigger" {
  statement_id = "s3-to-trigger-lambda"
  function_name = aws_lambda_function.rekognition-faceprints.function_name
  source_arn = var.source-s3-bucket-arn
  action = "lambda:InvokeFunction"
  principal = "s3.amazonaws.com"
}