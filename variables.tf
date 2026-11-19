variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket (must be globally unique)"
  type        = string
  default     = "my-static-website-rahul-kujur-2024"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}
