resource "aws_s3_bucket" "random-bucket" {
  bucket = "random-bucket-12345"
  force_destroy = true
}