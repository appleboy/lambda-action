# 🚀 lambda-action

[GitHub Action](https://developer.github.com/actions/) for deploying Lambda code to an existing function

<img src="images/lambda-workflow.png" />

## Usage

Upload zip file to AWS Lambda function.

```
action "Upload Simple Lambda" {
  uses = "appleboy/lambda-action@master"
  secrets = [
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
    "AWS_REGION"
  ]
  args = [
    "--function-name", "hello-world",
    "--source", "main.go",
    "--source", "source.go",
    "--source", "extra.go",
  ]
}
```

## Environment variables

* ZIP_FILE - file path of zip file
* SOURCE - file list you want to zip
* S3_BUCKET - An Amazon S3 bucket in the same AWS Region as your function. The bucket can be in a different AWS account.
* S3_KEY - The Amazon S3 key of the deployment package.
* DRY_RUN - Set to true to validate the request parameters and access permissions without modifying the function code.

### Example

zip source file and upload to aws lambda.

```
action "Upload Simple Lambda" {
  uses = "appleboy/lambda-action@master"
  secrets = [
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
    "AWS_REGION"
  ]
  args = [
    "--function-name", "hello-world",
    "--source", "main.go",
    "--source", "source.go",
    "--source", "extra.go",
  ]
}
```

upload single zip file.

```
action "Upload Simple Lambda" {
  uses = "appleboy/lambda-action@master"
  secrets = [
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
    "AWS_REGION"
  ]
  args = [
    "--function-name", "hello-world",
    "--zip-file", "output.zip",
  ]
}
```

Set dry run mode to validate the request parameters and access permissions without modifying the function code.

```
action "Upload Simple Lambda" {
  uses = "appleboy/lambda-action@master"
  secrets = [
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
    "AWS_REGION"
  ]
  args = [
    "--function-name", "hello-world",
    "--zip-file", "output.zip",
    "--dry-run",
  ]
}
```

## Secrets

* `AWS_REGION` - aws region
* `AWS_ACCESS_KEY_ID` - aws access key id
* `AWS_SECRET_ACCESS_KEY` - aws secret key
