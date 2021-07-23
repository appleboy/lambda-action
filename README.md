# 🚀 lambda-action

[GitHub Action](https://developer.github.com/actions/) for deploying Lambda code to an existing function

## Usage

Upload zip file to AWS Lambda function.

```yaml
name: deploy to lambda
on: [push]
jobs:

  deploy_zip:
    name: deploy lambda function
    runs-on: ubuntu-latest
    strategy:
      matrix:
        go-version: [1.13.x]
    steps:
      - name: checkout source code
        uses: actions/checkout@v1
      - name: Install Go
        uses: actions/setup-go@v1
        with:
          go-version: ${{ matrix.go-version }}
      - name: Build binary
        run: |
          cd example && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -a -o main main.go && zip deployment.zip main
      - name: default deploy
        uses: appleboy/lambda-action@master
        with:
          aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws_region: ${{ secrets.AWS_REGION }}
          function_name: gorush
          zip_file: example/deployment.zip
          memory_size: 128
          timeout: 10
          handler: foobar
          role: arn:aws:iam::xxxxxxxxxxx:role/test1234
          runtime: nodejs12.x
```

Deploy lambda function with source file

```yaml
name: deploy to lambda
on: [push]
jobs:

  deploy_source:
    name: deploy lambda from source
    runs-on: ubuntu-latest
    steps:
      - name: checkout source code
        uses: actions/checkout@v1
      - name: default deploy
        uses: appleboy/lambda-action@master
        with:
          aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws_region: ${{ secrets.AWS_REGION }}
          function_name: gorush
          source: example/index.js
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
      uses: appleboy/lambda-action@master
      with:
        aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws_region: ${{ secrets.AWS_REGION }}
        function_name: gorush
        zip_file: output.zip
        dry_run: true
```

Deploy from a specific branch, `master` or `release`.

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
      if: github.ref == 'refs/heads/master'
      uses: appleboy/lambda-action@master
      with:
        aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws_region: ${{ secrets.AWS_REGION }}
        function_name: gorush
        zip_file: output.zip
        dry_run: true
```

Add multiple environment:

```diff
name: deploy to lambda
on: [push]
jobs:

  deploy:
    name: deploy lambda function
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: AWS Lambda Deploy
      if: github.ref == 'refs/heads/master'
      uses: appleboy/lambda-action@master
      with:
        aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws_region: ${{ secrets.AWS_REGION }}
        function_name: gorush
        zip_file: output.zip
        dry_run: true
+       environment: foo=bar,author=appleboy
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
* debug - Show debug message after upload the lambda successfully (default as `false`).
* publish - Set to true to publish a new version of the function after updating the code. (default as `true`).
* reversion_id - Only update the function if the revision ID matches the ID that is specified.
* memory_size - The amount of memory that your function has access to. Increasing the function's memory also increases its CPU allocation. The default value is 128 MB. The value must be a multiple of 64 MB.
* timeout - The amount of time that Lambda allows a function to run before stopping it. The default is 3 seconds. The maximum allowed value is 900 seconds.
* handler - The name of the method within your code that Lambda calls to execute your function.
* role - The function's execution role. Pattern: `arn:(aws[a-zA-Z-]*)?:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+`
* runtime - The identifier of the function's runtime. `nodejs10.x | nodejs12.x | java8 | java8.al2 | java11 | python2.7 | python3.6 | python3.7 | python3.8 | dotnetcore2.1 | dotnetcore3.1 | go1.x | ruby2.5 | ruby2.7 | provided | provided.al2`
* environment - Lambda Environment variables. example: `foo=bar,author=appleboy`
* image_uri - URI of a container image in the Amazon ECR registry.
* subnets - Select the VPC subnets for Lambda to use to set up your VPC configuration.
* securitygroups - Choose the VPC security groups for Lambda to use to set up your VPC configuration.
* description - A description of the function.
* layers - A list of function layers, to add to the function's execution environment. Specify each layer by its ARN, including the version.

See the [UpdateFunctionConfiguration](https://docs.amazonaws.cn/en_us/lambda/latest/dg/API_UpdateFunctionConfiguration.html) for detail information.

## AWS Policy

Add the following AWS policy if you want to integrate with GitHub Actions. Please change `REGION`, `ACCOUNT` and `LAMBDA_NAME` variable to your specfic data.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "iam:ListRoles",
        "lambda:UpdateFunctionCode",
        "lambda:CreateFunction",
        "lambda:UpdateFunctionConfiguration"
      ],
      "Resource": "arn:aws:lambda:${REGION}:${ACCOUNT}:function:${LAMBDA_NAME}"
    }
  ]
}
```
