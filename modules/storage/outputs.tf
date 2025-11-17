output "bucket_name" {
  value = aws_s3_bucket.appbucket.bucket
}

output "dynamodb_name" {
  value = aws_dynamodb_table.appdb.name
}
