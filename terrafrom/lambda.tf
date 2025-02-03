module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "lambda_func"
  description   = "Random dice rolls"
  handler       = "lambda_func.lambda_handler"
  runtime       = "python3.12"

  source_path = "${path.module}/../src/lambda_func.py"

  timeout = 10
  attach_policy_statements = true
  policy_statements = {

   s3_write = {
        effect = "Allow"
        actions = ["s3:PutObject"]
        resources = ["${aws_s3_bucket.random-bucket.arn}/*"]
    }
}

  store_on_s3 = true
  s3_bucket   = aws_s3_bucket.random-bucket.id

  tags = {
    Name = "lambda_func"
  }
}