#!/bin/bash
TEMPLATE_FILE='../master-waf.yaml'
PACKAGED_FILE='../output/master-waf.packaged.yaml'

mkdir -p ../output  || exit

aws cloudformation package \
--template-file $TEMPLATE_FILE \
--s3-bucket "$BUCKET" \
--s3-prefix "$PREFIX/waf" \
--output-template-file $PACKAGED_FILE \
--profile "$AWS_PROFILE" \
--region "$AWS_REGION"

aws s3 cp $PACKAGED_FILE s3://$BUCKET/$PREFIX/waf/master-waf.packaged.yaml --profile $AWS_PROFILE
