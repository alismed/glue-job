output "glue_job_name" {
  value = aws_glue_job.job.name
}

output "glue_job_role_arn" {
  value = aws_iam_role.glue_role.arn
}

output "glue_catalog_database_name" {
  value = aws_glue_catalog_database.glue_catalog_database.name
}

output "etl_script_s3_path" {
  value = "s3://${aws_s3_object.etl_script.bucket}/${aws_s3_object.etl_script.key}"
}