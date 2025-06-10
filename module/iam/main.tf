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