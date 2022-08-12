$PACKAGED_FILE='../output/master-vpc.packaged.yaml'

echo " deploying stack $COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-VPC"

aws cloudformation deploy `
--template-file $PACKAGED_FILE `
--stack-name $COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-VPC `
--parameter-overrides `
  StackNumber=$STACK_NUMBER `
  MasterBaseStack=$COID-$ASSETID-$APID-$SID-ST-$STACK_NUMBER-MASTER-BASE  `
  VPCTenancy=$VPC_TENANCY `
  AvailabilityZones=$AVAILABILITY_ZONE `
  VPCCIDR=$VPC_CIDR `
  PublicSubnet1CIDR=$PUBLIC_SUBNET_1_CIDR `
  PublicSubnet2CIDR=$PUBLIC_SUBNET_2_CIDR `
  AppPrivateSubnet1CIDR=$APP_PRIVATE_SUBNET_1_CIDR `
  AppPrivateSubnet2CIDR=$APP_PRIVATE_SUBNET_2_CIDR `
  DbPrivateSubnet1CIDR=$DB_PRIVATE_SUBNET_1_CIDR `
  DbpPrivateSubnet2CIDR=$DB_PRIVATE_SUBNET_2_CIDR `
  CreateNatGateway=$CREATE_NATGATEWAY `
  CreatePrivateSubnets=$CREATE_PRIVATE_SUBNETS `
  NumberOfAZs=$NUMBER_AZs `
--profile $AWS_PROFILE `
--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND `
--region $AWS_REGION `
--tags APID=$APID ASSETID=$ASSETID COID=$COID ENV=$ENV SID=$SID