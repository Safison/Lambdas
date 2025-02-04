data "archive_file" "lambda"{
    type = "zip"
    source_file = "${path.module}/save_monster.py"
    output_path = "${path.module}/save_monster.zip"
    
}


resource "aws_lambda_function" "save_monster" {
    filename = data.archive_file.lambda.output_path
    function_name = "sprint_monster"
    role = aws_iam_role.iam-for-lambda-role.arn
    handler = "save_monster.lambda_handler"
    runtime = "python3.13"
}

resource "aws_lambda_permission" "allow_s3" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.save_monster.function_name
  principal = "s3.amazonaws.com"
  source_arn = aws_s3_bucket.random-bucket.arn
  source_account = data.aws_caller_identity.current.account_id
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.save_monster.function_name
  principal = "logs.eu-west-2.amazonaws.com"
  source_arn = aws_cloudwatch_log_group.default.arn
  source_account = data.aws_caller_identity.current.account_id
}