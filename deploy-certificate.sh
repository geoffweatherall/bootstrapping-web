#!/usr/bin/env bash
set -eo pipefail

# required parameter is apex domain name
if [ -z "$1" ]
  then
    echo "specify apex domain, e.g. mysite.com"
    exit 1
fi

domain_name=$1
stack_name=${domain_name//./-}-certificate
shift

aws cloudformation deploy \
  --template-file infrastructure/domain-certificate.cfn.yaml \
  --stack-name ${stack_name} \
  --parameter-overrides ApexDomain=${domain_name} \
  "$@"