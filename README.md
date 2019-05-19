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
    "--function-name", "gorusg",
    "--zip-file", "output.zip",
  ]
}
```
