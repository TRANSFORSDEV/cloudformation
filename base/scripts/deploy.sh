#!/bin/bash
echo " deploying stack $COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-BASE"
aws cloudformation deploy \
--template-file "$PACKAGED_FILE" \
--stack-name "$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-BASE" \
--parameter-overrides \
  StackNumber=$STACK_NUMBER \
  VPC=$VPC \
  COID=$COID \
  ASSETID=$ASSETID \
  APID=$APID \
  ENV=$ENV \
  SID=$SID \
  SupportEmail=$SUPPORT_EMAIL \
--profile "$AWS_PROFILE" \
--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--region us-east-1 \
--tags APID=$APID ASSETID=$ASSETID COID=$COID ENV=$ENV SID=$SID