#! /bin/bash
currentPath=$(dirname "$0")
source ${currentPath}/variables.sh

aws cloudformation package --template-file $(pwd)/template.yml --s3-bucket ${CF_BUCKET} --output-template-file template-export.yml

aws cloudformation deploy \
    --template-file /Users/yilu/git/lyi-cloudformation-learn/template-export.yml \
    --stack-name ${STACK_NAME} \
    --role-arn arn:aws:iam::331159120815:role/lyi-cf-role \
    --capabilities CAPABILITY_IAM