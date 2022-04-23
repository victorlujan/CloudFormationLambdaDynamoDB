#!/bin/bash
set -eo pipefail

cd lambda
GOOS=linux go build main.go
cd ../
aws cloudformation package --template-file template.yml --s3-bucket $BUCKET_NAME  --output-template-file out.yml
aws cloudformation deploy --template-file out.yml --stack-name user-lambda --capabilities CAPABILITY_NAMED_IAM
