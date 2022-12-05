# URI to access the web site
output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
  description = "Endpoint where the static web site was exposed"
}