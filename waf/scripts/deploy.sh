#!/bin/bash
aws cloudformation deploy \
--template-file "$PACKAGED_FILE" \
--stack-name "$COID-$ASSETID-$APID-$SID-ST-00-MASTER-WEB" \
--parameter-overrides \
  StackNumber=$STACK_NUMBER \
  BaseStack="$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-BASE"  \
  Domain=$WEB_DOMAIN \
  HostedZoneId=$HOSTED_ZONE \
  CertificateArn=$CERTIFICATE \
--profile "$AWS_PROFILE" \
--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--region us-east-1 \
--tags APID=$APID ASSETID=$ASSETID COID=$COID ENV=$ENV SID=$SID