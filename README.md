Pivoting to use AWS SAM CLI and Lambda Powertools. Personal template: https://github.com/rbarman/sam-lambda-function-url



-----


# README

[manual] Steps I currently use to deploy lambda functions with docker images

Long term goal is to automate and leverage [powertools](https://docs.powertools.aws.dev/lambda/python/latest/)

## General

Suppose:
* Building a Lambda function called `lambda-workflow-runner`
* Account id is `99999999`


## Local Dev

1) python3 -m venv venv
2) source venv/bin/activate
3) pip3 install -r requirements.txt

## Local Docker

1) Create Dockerfile
2) Put environment variables in .env file
3) Turn on Docker Desktop
4) docker build -t lambda-workflow-runner .
5) docker run -p 9000:8080 --env-file .env lambda-workflow-runner
6) Test it

curl -X POST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"my_data_key": "my_data_value"}'

## AWS ECR

1) Create a new private repository
2) Select repo and click on "view push commands"
3) Run the commands:
- aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 99999999.dkr.ecr.us-east-2.amazonaws.com
- docker tag lambda-workflow-runner:latest 99999999.dkr.ecr.us-east-2.amazonaws.com/lambda-workflow-runner:latest
- docker push 99999999.dkr.ecr.us-east-2.amazonaws.com/lambda-workflow-runner:latest

## AWS Lambda

1) Select to build with a container image
2) Select the image
3) Create a Lambda Test Event
4) Add environment variables
5) Create a test event
