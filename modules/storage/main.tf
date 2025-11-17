#########################################
# S3 Bucket
#########################################
resource "aws_s3_bucket" "bucket" {
    bucket = "${var.project_name}-bucket"

    tags = {
        Name = "${var.project_name}-bucket"
    }
}

#########################################
# DynamoDB
#########################################
resource "aws_dynamodb_table" "table" {
    name         = "${var.project_name}-table"
    billing_mode = "PAY_PER_REQUEST"

    hash_key = "id"

    attribute {
        name = "id"
        type = "S"
    }

    tags = {
        Name = "${var.project_name}-ddb"
    }
}
