#!/bin/bash
stack=$1
environment=$2
file_environment="environment/environment.${environment}.sh"
echo "getting environment from file ${file_environment}"
source "${file_environment}" || exit

cd "${stack}/scripts"  || exit

echo "packaging ${stack} ${environment}"
source "package.sh" || exit

echo "deploying ${stack} ${environment}"

export STACK_NUMBER=${3:-00}
source "deploy.sh" || exit

