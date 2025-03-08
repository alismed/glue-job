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

variable "role_name" {
  description = "Name of the Glue IAM role"
  type        = string
  default     = "GlueServiceRole"
}

variable "job_name" {
  description = "Name of the Glue job"
  type        = string
  default     = ""
}

variable "database_name" {
  description = "Name of the Glue catalog database"
  type        = string
  default     = "glue_catalog_database"
}

variable "glue_version" {
  description = "Version of Glue to use"
  type        = string
  default     = "4.0"
}

variable "worker_type" {
  description = "Type of worker for Glue job"
  type        = string
  default     = "G.1X"
}

variable "number_of_workers" {
  description = "Number of workers for Glue job"
  type        = number
  default     = 2
}

variable "python_version" {
  description = "Python version for Glue job"
  type        = string
  default     = "3"
}

variable "log_group" {
  description = "CloudWatch log group for Glue job"
  type        = string
  default     = "/aws-glue/jobs"
}