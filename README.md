## Spring Boot Application
This project is a simple example of how to create a Glue Job using Terraform. 

### Requirements
- AWS Cli
- Terraform Cli
- Java 17
- Maven
- Docker*
- Localstack Cli*
- S3 Bucket pre-built in AWS

*Not essential, but recommended.

### Localstack
To use LocalStack on your local machine, add a profile in the aws cli settings: `.aws/credentials` and `.aws/config`

### Terraform State
The S3 bucket pre-built is used to store the terraform state file. The bucket name is defined in the `backend.tf` file.

```shell
mvn -f app clean & mvn -f app build
```

```shell
mvn -f app spring-boot:run
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
