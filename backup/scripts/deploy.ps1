#!/bin/bash
$PACKAGED_FILE='../output/master-backup.packaged.yaml'

aws cloudformation deploy `
--template-file $PACKAGED_FILE `
--stack-name $COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-BACKUP `
--parameter-overrides `
  StackNumber=$STACK_NUMBER `
  MasterBaseStack=$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-BASE `
  BackupPlanName=$BACKUP_PLAN_NAME `
  BackupVaultName=$BACKUP_VAULT_NAME `
  BackupSelectionName=$BACKUP_SELECTION_NAME `
  BackupTagKey=$BACKUP_TAGKEY `
  BackupTagValue=$BACKUP_TAGVALUE `
  RuleName1=$RULE_NAME_1 `
  BackupFrecuency1=$BACKUP_FRECUENCY_1 `
  MoveToColdStorageAfterDays1=$MOVE_TO_COLD_STORAGE_AFTER_DAYS_1 `
  DeleteAfterDays1=$DELETE_AFTER_DAY `
  RuleName2=$RULE_NAME_2 `
  BackupFrecuency2=$BACKUP_FRECUENCY_2 `
  MoveToColdStorageAfterDays2=$MOVE_TO_COLD_STORAGE_AFTER_DAYS_2 `
  RuleName3=$RULE_NAME_3 `
  BackupFrecuency3=$BACKUP_FRECUENCY_3 `
  MoveToColdStorageAfterDays3=$MOVE_TO_COLD_STORAGE_AFTER_DAYS_3 `
  BackupRoleName=$BACKUP_ROLE_NAME `
--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND `
--region $AWS_REGION `
--tags APID=$APID ASSETID=$ASSETID COID=$COID ENV=$ENV SID=$SID `
--profile $AWS_PROFILE