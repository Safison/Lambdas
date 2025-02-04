data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam-for-lambda-role" {
  name               = "iam-for-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "s3-policy" {
  statement {
    sid = "1"
    actions = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.random-bucket.arn}/*", ]
  }
} 

resource "aws_iam_policy" "s3-policy" {
  name        = "s3-policy"
  policy      = data.aws_iam_policy_document.s3-policy.json
}

resource "aws_iam_policy_attachment" "s3-attach" {
  name       = "s3-attachment"
  roles      = [aws_iam_role.iam-for-lambda-role.name]
  policy_arn = aws_iam_policy.s3-policy.arn
}

data "aws_iam_policy_document" "cloudwatch-policy" {
  statement {
    effect = "Allow"
    actions = ["logs:*"]
    resources = ["*"]
  } 
} 

resource "aws_iam_policy" "cloudwatch-policy" {
  name        = "cloudwatch-policy"
  policy      = data.aws_iam_policy_document.cloudwatch-policy.json
}

resource "aws_iam_policy_attachment" "cloudwatch-attach" {
  name       = "cloudwatch-attachment"
  roles      = [aws_iam_role.iam-for-lambda-role.name]
  policy_arn = aws_iam_policy.cloudwatch-policy.arn
}