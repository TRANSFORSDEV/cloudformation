#!/bin/bash
$stack=$args[0]
$environment=$args[1]
$file_environment="environment/environment.${environment}.ps1"
echo "getting environment from file ${file_environment}"
. $file_environment

cd "${stack}/scripts"

echo "packaging ${stack} ${environment}"
.\package.ps1

echo "deploying ${stack} ${environment}"

$STACK_NUMBER="01"
.\deploy.ps1

cd ../..

