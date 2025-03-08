variable "region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "Define the aws profile"
  type        = string
  default     = ""
}

variable "etl_bucket" {
  description = "Name of the S3 bucket for ETL scripts (must be an existing bucket)"
  type        = string
}