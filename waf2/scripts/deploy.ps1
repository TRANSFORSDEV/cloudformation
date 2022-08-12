#!/bin/bash
$PACKAGED_FILE='../output/master-waf.packaged.yaml'

aws cloudformation deploy `
--template-file $PACKAGED_FILE `
--stack-name $COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-WAF `
--parameter-overrides `
  StackNumber=$STACK_NUMBER `
  MasterBaseStack=$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-BASE `
  MasterElbStack=$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-ELB-IPS `
  MasterApiGatewayStack="" `
  WafName=$WAF_APP_NAME `
  DefaultAction=$WAF_APP_DEFAULT_ACTION `
  A1Injection=$A1_INJECTION `
  A3CrossSiteScripting=$A3_CROSS_STINE_SCRIPTING `
  A4BrokenAccessControl=$A4_BROKEN_ACCESS_CONTROL `
  A5SecurityMisconfiguration=$A5_SECURITY_MISCONFIGURATION `
  A7InsufficientAttackProtection=$A7_INSUFFICIENT_ATTACK_PROTECTION `
  A8CrossSiteRequestForgery=$A8_CROSS_SITE_REQUEST_FORGERY `
  MaxExpectedBodySize=$MAX_EXPECTED_BODY_SIZE `
  MaxExpectedURISize=$MAX_EXPECTED_URI_SIZE `
  MaxExpectedQueryStringSize=$MAX_EXPECTED_QUERY_STRING_SIZE `
  MaxExpectedHeaderAuthorization=$MAX_EXPECTED_HEADER_AUTORIZATION `
  MaxExpectedHeaderCSRF=$MAX_EXPECTED_HEADER_CSRF `
  RequestThreshold=$REQUEST_TRESHOLD `
  WAFBlockPeriod=$WAF_BLOCK_PERIOD `
--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND `
--region $AWS_REGION `
--tags APID=$APID ASSETID=$ASSETID COID=$COID ENV=$ENV SID=$SID `
--profile $AWS_PROFILE