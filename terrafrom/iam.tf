

data "aws_iam_policy_document" "lamda_asume_role" {
  
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }

  statement {
    
    actions = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.random-bucket.arn}/*"]
  }

  statement {
    effect = "Allow"
    actions = ["logs:*"]
    resources = ["*"]
  }
  

}

 
resource "aws_iam_role" "monster_role" {
    name = "monster_iam_role"
    assume_role_policy = data.aws_iam_policy_document.lamda_asume_role.json

}

resource "aws_iam_policy" "s3_role_policy" {
    name = "s3_policy"
    policy = data.aws_iam_policy_document.lamda_asume_role.json

}

# resource "aws_iam_policy "s3_policy" {
#   name = "s3_policy"
#   policy = data.aws_iam_policy_document.lamda_asume_role.json
# }

