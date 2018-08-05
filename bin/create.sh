#! /bin/bash
currentPath=$(dirname "$0")
source ${currentPath}/variables.sh
aws s3api create-bucket \
    --bucket ${CF_BUCKET} \
    --acl private \
    --create-bucket-configuration \
    "{
        \"LocationConstraint\": \"ap-southeast-2\"
    }"

arpd=$(node ${currentPath}/url.js CF_ROLE.json);
aws iam create-role \
    --role-name ${CF_ROLE} \
    --assume-role-policy-document ${arpd}

pd=$(node ${currentPath}/url.js CF_POLICY.json);
 aws iam put-role-policy \
    --role-name ${CF_ROLE} \
    --policy-name lyi-cf-policy \
    --policy-document ${pd}

# aws cloudformation create-stack \
#     --stack-name ${STACK_NAME} \
#     --role-arn arn:aws:iam::331159120815:role/lyi-cf-role \
#     --template-file ../template.yml \
#     --on-failure ROLLBACK
aws cloudformation package --template-file $(pwd)/template.yml --s3-bucket ${CF_BUCKET} --output-template-file template-export.yml

aws cloudformation deploy \
    --template-file /Users/yilu/git/lyi-cloudformation-learn/template-export.yml \
    --stack-name ${STACK_NAME} \
    --role-arn arn:aws:iam::331159120815:role/lyi-cf-role \
    --capabilities CAPABILITY_IAM