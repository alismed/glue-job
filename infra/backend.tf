terraform {
  backend "s3" {
    bucket  = "alismed-terraform"
    key     = "glue-job/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}