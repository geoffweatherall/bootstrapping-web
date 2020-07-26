#!/usr/bin/env bash
set -eo pipefail

# required parameter is apex domain name
if [ -z "$1" ]
  then
    echo "specify apex domain, e.g. mysite.com"
    exit 1
fi

domain_name=$1
stack_name=${domain_name//./-}-hosted-zone
shift

aws cloudformation deploy \
  --template-file infrastructure/hosted-zone.cfn.yaml \
  --stack-name ${stack_name} \
  --parameter-overrides ApexDomain=${domain_name} "$@"

echo Name servers:
aws cloudformation describe-stacks \
   --stack-name ${stack_name} \
   --query "Stacks[].Outputs[?OutputKey=='NameServers'].OutputValue" \
   --output text