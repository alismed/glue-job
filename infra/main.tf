resource "aws_iam_role" "glue_role" {
  name               = "GlueServiceRole"
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
  name = "glue_catalog_database"
}

resource "aws_s3_object" "etl_script" {
  bucket = var.etl_bucket
  key    = "app/etl.py"
  source = "${path.module}/../app/etl.py"
  etag   = filemd5("${path.module}/../app/etl.py")
}

resource "aws_glue_job" "job" {
  name     = "job"
  role_arn = aws_iam_role.glue_role.arn

  command {
    script_location = "s3://${aws_s3_object.etl_script.bucket}/${aws_s3_object.etl_script.key}"
    python_version  = "3"
    name            = "glueetl"
  }

  default_arguments = {
    "--job-language"              = "python"
    "--continuous-log-logGroup"   = "/aws-glue/jobs"
    "--enable-continuous-logging" = "true"
    "--enable-metrics"            = "true"
  }

  glue_version      = "4.0"
  execution_class   = "FLEX"
  worker_type       = "G.1X"
  number_of_workers = 2
}