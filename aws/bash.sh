#!/bin/bash
GITHUB_REPO="https://github.com/AlukoVC/srv-web"
JSON_FILE="srvweb.json"
STACK_NAME="stack"
git clone $GITHUB_REPO
cd $(basename $GITHUB_REPO)
JSON_CONTENT=$(cat $JSON_FILE)
aws cloudformation deploy --stack-name $STACK_NAME --template-file $JSON_FILE --capabilities CAPABILITY_IAM
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME
STACK_ARN=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query 'Stacks[0].StackId' --output text)
echo "Pile CloudFormation créée avec succès. ARN: $STACK_ARN"
