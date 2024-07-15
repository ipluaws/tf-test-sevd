output "bucket_id" {
  description = "ID of the S3 bucket"
  value       = aws_s3_bucket.spa_bucket.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.spa_bucket.arn
}

output "bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = aws_s3_bucket.spa_bucket.bucket_regional_domain_name
}

output "spa_bucket_name" {
  value = aws_s3_bucket.spa_bucket.id
  description = "Name of the SPA bucket"
}
