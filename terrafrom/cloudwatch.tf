resource "aws_cloudwatch_log_group" "default" {
  name = "/default"
}

resource "aws_cloudwatch_log_subscription_filter" "logging" {
  depends_on      = [aws_lambda_permission.allow_cloudwatch]
  destination_arn = aws_lambda_function.save_monster.arn
  filter_pattern  = "ERROR"
  log_group_name  = aws_cloudwatch_log_group.default.name
  name            = "logging_default"
}