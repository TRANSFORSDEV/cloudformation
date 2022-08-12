#!/bin/bash
stack=$1
environment=$2
file_environment="environment/environment.${environment}.sh"
echo "getting environment from file ${file_environment}"
source "${file_environment}" || exit

echo "packaging ${stack} ${environment}"
cd "${stack}/scripts"  || exit
source "package.sh" || exit

