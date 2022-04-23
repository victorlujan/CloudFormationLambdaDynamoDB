#!/bin/bash
# set -eo pipefail
# FUNCTION=$(aws cloudformation describe-stack-resource --stack-name blank-go --logical-resource-id function --query 'StackResourceDetail.PhysicalResourceId' --output text)

# while true; do
#   aws lambda invoke --function-name $FUNCTION --payload file://event.json out.json
#   cat out.json
#   echo ""
#   sleep 2
# done



API=$(aws cloudformation describe-stack-resource --stack-name user-lambda --logical-resource-id ApiGatewayRestApi --query 'StackResourceDetail.PhysicalResourceId' --output text)



curl --location --request POST 'https://dklz33q8xl.execute-api.eu-west-1.amazonaws.com/v0/lambda' --header 'Content-Type: application/json' --data-raw '
    {
    "email": "campillovictor@live.com",
    "name": "Victor",
    "password":"passrd",
    "phone":"902222"
    }'