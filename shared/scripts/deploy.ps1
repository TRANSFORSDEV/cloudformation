$PACKAGED_FILE='../output/master-shared.packaged.yaml'

aws cloudformation deploy `
--template-file $PACKAGED_FILE `
--stack-name $COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-SHARED `
--parameter-overrides `
  StackNumber=$STACK_NUMBER `
  MasterBaseStack=$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-BASE  `
  MasterVPCStack=$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-VPC  `
  AlarmsMail=$ALARMS_EMAIL `
  ClusterMasterUsername=$DB_USERNAME `
  ClusterMasterUserPassword=$BD_PASSWORD `
  HostedZoneName=$HOSTED_ZONE_NAME `
  HostedZoneId=$HOSTED_ZONE_ID `
  Route53EnableLogging=$ENABLE_LOGIN `
  Route53LogRetentionDays=$LOG_RETENTION_DAYS `
--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND `
--region $AWS_REGION `
--tags APID=$APID ASSETID=$ASSETID COID=$COID ENV=$ENV SID=$SID `
 --profile $AWS_PROFILE