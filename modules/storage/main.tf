resource "aws_s3_bucket" "appbucket" {
    bucket = "${var.project_name}-bucket"
}

resource "aws_dynamodb_table" "appdb" {
    name         = "${var.project_name}-db"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "id"

    attribute {
        name = "id"
        type = "S"
    }
}
