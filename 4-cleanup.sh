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

if [ -f bucket-name.txt ]; then
    ARTIFACT_BUCKET=$(cat bucket-name.txt)
    echo "Borrando $ARTIFACT_BUCKET"
        
     aws s3 rb --force s3://$ARTIFACT_BUCKET; rm bucket-name.txt;

    
fi


rm -f out.yml out.json lambda/main
