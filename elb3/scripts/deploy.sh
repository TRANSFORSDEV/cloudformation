#!/bin/bash
echo " deploying stack $COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-ELB"
aws cloudformation deploy \
--template-file "$PACKAGED_FILE" \
--stack-name $COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-ELB \
--parameter-overrides \
  StackNumber=$STACK_NUMBER \
  MasterBaseStack=$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-BASE \
  MasterSharedStack=$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-SHARED \
  Subnets=$PUBLIC_SUBNET \
  HostedZoneId=$HOSTED_ZONE \
  DomainName=$ELB_DOMAIN \
--profile $AWS_PROFILE \
--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--region us-east-1 \
--tags APID=$APID ASSETID=$ASSETID COID=$COID ENV=$ENV SID=$SID