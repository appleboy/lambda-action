# 🚀 lambda-action

[GitHub Action](https://developer.github.com/actions/) for deploying Lambda code to an existing function

## Usage

Upload zip file to AWS Lambda function.

```yaml
name: deploy to lambda
on: [push]
jobs:

  deploy:
    name: deploy lambda function
    runs-on: ubuntu-latest
    steps:
      - name: default deploy
        uses: appleboy/ssh-action@master
        with:
          aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws_region: ${{ secrets.AWS_REGION }}
          function_name: gorush
          zip_file: output.zip
```

Deploy lambda function with source file

```yaml
name: deploy to lambda
on: [push]
jobs:

  deploy:
    name: deploy lambda function
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: AWS Lambda Deploy
      uses: appleboy/lambda-action
      with:
        aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws_region: ${{ secrets.AWS_REGION }}
        function_name: gorush
        source: main.go,source.go,extra.go
```

Set dry run mode to validate the request parameters and access permissions without modifying the function code.

```yaml
name: deploy to lambda
on: [push]
jobs:

  deploy:
    name: deploy lambda function
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: AWS Lambda Deploy
      uses: appleboy/lambda-action
      with:
        aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws_region: ${{ secrets.AWS_REGION }}
        function_name: gorush
        zip_file: output.zip
        dry_run: true
```

## Input variables

See [action.yml](./action.yml) for more detailed information.

* aws_region - aws region
* aws_access_key_id - aws access key id
* aws_secret_access_key - aws secret key
* zip_file - file path of zip file
* source - file list you want to zip
* s3_bucket - An Amazon S3 bucket in the same AWS Region as your function. The bucket can be in a different AWS account.
* s3_key - The Amazon S3 key of the deployment package.
* dry_run - Set to true to validate the request parameters and access permissions without modifying the function code.
