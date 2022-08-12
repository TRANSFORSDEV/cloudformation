$PACKAGED_FILE='../output/master-elb.packaged.yaml'

echo " deploying stack $COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-ELB"

aws cloudformation deploy `
--template-file $PACKAGED_FILE `
--stack-name $COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-ELB `
--parameter-overrides `
  StackNumber=$STACK_NUMBER `
  MasterBaseStack=$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-BASE `
  MasterSharedStack=$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-SHARED `
  MasterVPCStack=$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-VPC `
  DomainName=$API_DOMAIN `
  TypeELB=$TYPE_ELB `
  HTTPSCertificateArn=$CERTIFICATE `
--profile $AWS_PROFILE `
--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND `
--region $AWS_REGION `
--tags APID=$APID ASSETID=$ASSETID COID=$COID ENV=$ENV SID=$SID