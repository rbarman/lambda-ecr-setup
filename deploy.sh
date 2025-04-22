#!/bin/bash

set -e  # exit on any error

REGION=us-east-2
REPO=lambda-workflow-runner
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_URI="$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO"

MODE=$1 # ECR or LOCAL
# set default to LOCAL
if [ -z "$MODE" ]; then
  MODE="LOCAL"
fi

if [[ "$MODE" == "ECR" ]]; then
  echo "Logging in to ECR..."
  aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_URI

  echo "Building Docker image..."
  docker build -t $REPO .

  echo "Tagging image..."
  docker tag $REPO:latest $ECR_URI:latest

  echo "Pushing to ECR..."
  docker push $ECR_URI:latest

  echo "Image pushed to $ECR_URI"

elif [[ "$MODE" == "LOCAL" ]]; then
  echo "Building Docker image..."
  docker build -t $REPO .

  echo "Running container locally..."
  docker run -p 9000:8080 --env-file .env $REPO

else
  echo "Unknown mode: $MODE"
  echo "Usage: ./deploy.sh [push|local]"
  exit 1
fi
