# S3 Bucket definition
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "Development"
  }
}

# Attach Allow access policy from internet
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.website_bucket.arn,
      "${aws_s3_bucket.website_bucket.arn}/*",
    ]
  }
}

# Defines ACL 
resource "aws_s3_bucket_acl" "website-acl" {
  bucket = aws_s3_bucket.website_bucket.id
  acl    = "public-read"
}

# Creates CORS
resource "aws_s3_bucket_cors_configuration" "website-cors" {
  bucket = aws_s3_bucket.website_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

# Configuration website
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = var.bucket_name

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
  depends_on = [aws_s3_bucket.website_bucket]
}

# Load HTML files to S3 Bucket
resource "aws_s3_object" "website_files" {
  for_each = fileset("${path.module}/resources", "**")
  bucket = aws_s3_bucket.website_bucket.id
  key    = each.value
  source = "${path.module}/resources/${each.value}"
}