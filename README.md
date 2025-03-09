## Python Glue Job with Terraform and Github Actions
This project is a simple example of how to create a Glue Job using Terraform. 

### Requirements
- AWS Cli
- Terraform Cli
- Python >= 3.12
- Docker*
- Localstack Cli*
- S3 Bucket pre-built in AWS**

*Not essential, but recommended.
**Is also possible to create a new bucket in this terraform script.

### Localstack
To use LocalStack on your local machine, add a profile in the aws cli settings:
- `.aws/credentials`
- `.aws/config`

### Terraform State
There is a S3 bucket pre-built used to store the terraform state file.
The bucket name is defined in the `backend.tf` file.

```shell
flake8 app
```

```shell
terraform -chdir=infra fmt
```

```shell
terraform -chdir=infra plan
```

```shell
terraform -chdir=infra apply -auto-approve
```

```shell
terraform -chdir=infra destroy -auto-approve
```
