#!/bin/sh
set -eux

readonly ADMIN_IP_ADDRESS=**.**.**.**/32
readonly SYSTEM_NAME=cfn-test
readonly TEMPLATE=security-group
readonly CFN_STACK_NAME=${SYSTEM_NAME}-${TEMPLATE}
readonly CFN_TEMPLATE=template/${TEMPLATE}.yml
changeset_option="--no-execute-changeset"

if [ $# = 1 ] && [ $1 = "deploy" ]; then
  echo "deploy mode"
  changeset_option=""
fi

if [ -z $ADMIN_IP_ADDRESS ]; then
  echo "IP none"
  exit
fi

aws cloudformation deploy \
  --stack-name ${CFN_STACK_NAME} \
  --template-file ${CFN_TEMPLATE} ${changeset_option} \
  --parameter-overrides \
    SystemName=${SYSTEM_NAME} \
    AdminIPAddress=${ADMIN_IP_ADDRESS}
