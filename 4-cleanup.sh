#!/bin/bash
set -eo pipefail
STACK=user-lambda
if [[ $# -eq 1 ]] ; then
    STACK=$1
    echo "Deleting stack $STACK"
fi
# FUNCTION=$(aws cloudformation describe-stack-resource --stack-name $STACK --logical-resource-id function --query 'StackResourceDetail.PhysicalResourceId' --output text)
aws cloudformation delete-stack --stack-name $STACK
echo "Deleted $STACK stack."
echo "Borrando $BUCKET_NAME"
aws s3 rb --force s3://$BUCKET_NAME 

rm -f out.yml out.json lambda/main
