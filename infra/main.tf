resource "aws_iam_role" "glue_role" {
  name               = var.role_name
  assume_role_policy = file("trust/role-glue.json")
}

resource "aws_iam_role_policy" "glue_policy" {
  name   = "GlueS3Policy"
  role   = aws_iam_role.glue_role.id
  policy = file("trust/policy-glue.json")
}

resource "aws_iam_role_policy_attachment" "glue" {
  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_glue_catalog_database" "glue_catalog_database" {
  name = var.database_name
}

resource "aws_s3_object" "etl_script" {
  bucket = var.etl_bucket
  key    = "app/etl.py"
  source = "${path.module}/../app/etl.py"
  etag   = filemd5("${path.module}/../app/etl.py")
}

resource "aws_glue_job" "job" {
  name     = var.job_name
  role_arn = aws_iam_role.glue_role.arn

  command {
    script_location = "s3://${aws_s3_object.etl_script.bucket}/${aws_s3_object.etl_script.key}"
    python_version  = var.python_version
    name            = "glueetl"
  }

  default_arguments = {
    "--job-language"              = "python"
    "--continuous-log-logGroup"   = var.log_group
    "--enable-continuous-logging" = "true"
    "--enable-metrics"            = "true"
  }

  glue_version      = var.glue_version
  execution_class   = "FLEX"
  worker_type       = var.worker_type
  number_of_workers = var.number_of_workers
}