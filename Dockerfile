FROM appleboy/drone-lambda:1.1.1-linux-amd64

# Github labels
LABEL "com.github.actions.name"="AWS Lambda Deploy"
LABEL "com.github.actions.description"="Deploying Lambda code to an existing function"
LABEL "com.github.actions.icon"="layers"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="https://github.com/appleboy/lambda-action"
LABEL "homepage"="https://github.com/appleboy"
LABEL "maintainer"="Bo-Yi Wu <appleboy.tw@gmail.com>"
LABEL "version"="0.0.1"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
