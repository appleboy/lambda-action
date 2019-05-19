workflow "Deploy Lambda Function" {
  on = "push"
  resolves = [
    "Upload Simple Lambda",
  ]
}

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
