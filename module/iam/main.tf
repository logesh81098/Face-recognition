#################################################################################################################################
#                                                         IAM Role
##################################################################################################################################

#IAM Role for Lambda function to create collection id in rekogntion service

resource "aws_iam_role" "rekognition-collection-id-role" {
  name = "Rekognition-collection-id"
  description = "IAM Role to create collection id in rekognition service"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
    ]
}
EOF
    tags = {
      Name = "Rekognition-collection-id"
      Project = "Face Recognition"
    }
}


##################################################################################################################################
#                                                      IAM policy
##################################################################################################################################

#IAM Policy for Lambda function to create collection id in rekogntion service

resource "aws_iam_policy" "rekogntion-collection-id-policy" {
  name = "Rekognition-collection-id-policy"
  description = "IAM Policy to create collection id in rekognition service"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Sid": "CreateCloudWatchLogGroup",
        "Effect": "Allow",
        "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*"
    },
    {
        "Sid": "CreateCollectionId",
        "Effect": "Allow",
        "Action": [
                "rekognition:CreateCollection",
                "rekognition:DeleteCollection",
                "rekognition:ListCollections"
        ],
        "Resource": "*"
    }
    ]

}
EOF
    tags = {
      Name = "Rekognition-collection-id-policy"
      Project = "Face Recognition"
    }
}

##################################################################################################################################
#                                              IAM Role and Policy Attachment
##################################################################################################################################

resource "aws_iam_role_policy_attachment" "rekognition-collection-id" {
  role = aws_iam_role.rekognition-collection-id-role.id
  policy_arn = aws_iam_policy.rekogntion-collection-id-policy.arn
}


#################################################################################################################################
#                                                         IAM Role
##################################################################################################################################

#IAM Role for Lambda function to generate faceprints and store it in dynamodb table

resource "aws_iam_role" "faceprints-role" {
  name = "Faceprints-Role"
  description = "IAM Role created for lambda function to process the source images from S3 bucket, generate faceprints from it and store faceprints in DynamoDB table"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
    "Effect": "Allow",
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "lambda.amazonaws.com"
    }
  }
  ]
}  
EOF
  tags = {
    Name = "Faceprints-Role"
    Project = "Face Recognition"
  }
}


##################################################################################################################################
#                                                      IAM policy
##################################################################################################################################

#IAM Policy for Lambda function to generate faceprints

resource "aws_iam_policy" "faceprints-policy" {
  name = "Faceprints-Policy"
  description = "IAM policy created for lambda function to process the source images from S3 bucket, generate faceprints from it and store faceprints in DynamoDB table"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
    "Sid": "CreateCloudWatchLogGroup",
    "Effect": "Allow",
    "Action": [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ],
    "Resource": "arn:aws:logs:*:*:*"
  },
  {
    "Sid": "GetInputsFromS3",
    "Effect": "Allow",
    "Action": [
      "s3:GetObject",
      "s3:HeadObject"
    ],
    "Resource": "arn:aws:s3:::face-rekognition-source-bucket/*"
  },
  {
    "Sid": "IndexesFace",
    "Effect": "Allow",
    "Action": [
      "rekognition:IndexFaces"
    ],
    "Resource": "arn:aws:rekognition:*:*:collection/*"
  },
  {
    "Sid": "StoreFaceprintsInDynamoDB",
    "Effect": "Allow",
    "Action": [
      "dynamodb:PutItem"
    ],
    "Resource": "arn:aws:dynamodb:*:*:table/Faceprints-Table"
  }
  ]

}  
EOF
  tags = {
    Name = "Faceprints-Policy"
    Project = "Face Recognition"
  }
}

##################################################################################################################################
#                                              IAM Role and Policy Attachment
##################################################################################################################################

resource "aws_iam_role_policy_attachment" "faceprints-role-policy" {
  role = aws_iam_role.faceprints-role.id
  policy_arn = aws_iam_policy.faceprints-policy.arn
}