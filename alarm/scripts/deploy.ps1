#!/bin/bash
$PACKAGED_FILE='../output/master-alarm.packaged.yaml'

aws cloudformation deploy `
--template-file $PACKAGED_FILE `
--stack-name $COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-ALARM `
--parameter-overrides `
  StackNumber=$STACK_NUMBER `
  MasterBaseStack=$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-BASE `
  MasterSharedStack=$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-SHARED `
  InstanceId1=$INSTANCE_ID_1 `
  AlarmName1=$ALARM_NAME_1 `
  TargetCpuUtilization1=$TARGET_CPU_UTILIZATION_1 `
  InstanceId2=$INSTANCE_ID_2 `
  AlarmName2=$ALARM_NAME_2 `
  TargetCpuUtilization2=$TARGET_CPU_UTILIZATION_2 `
  InstanceId3=$INSTANCE_ID_3 `
  AlarmName3=$ALARM_NAME_3 `
  TargetCpuUtilization3=$TARGET_CPU_UTILIZATION_3 `
--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND `
--region $AWS_REGION `
--tags APID=$APID ASSETID=$ASSETID COID=$COID ENV=$ENV SID=$SID `
--profile $AWS_PROFILE