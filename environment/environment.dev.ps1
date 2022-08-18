## TRANSFORS DEV
$BUCKET="transfors-template-arq"
$PREFIX="transfors/prd"
$AWS_PROFILE="default"
$AWS_REGION="us-east-1"

$COID="TNFR"
$ASSETID="0001"
$APID="TNF"
$SID="TNFP"
$ENV="PRD"

#PARAMETROS VPC
$VPC_TENANCY="default"
$AVAILABILITY_ZONE="us-west-2a,us-west-2b"
$VPC_CIDR="10.10.0.0/16"
$PUBLIC_SUBNET_1_CIDR="10.10.1.0/24"
$PUBLIC_SUBNET_2_CIDR="10.10.4.0/24"
$APP_PRIVATE_SUBNET_1_CIDR="10.10.2.0/24"
$APP_PRIVATE_SUBNET_2_CIDR="10.10.5.0/24"
$DB_PRIVATE_SUBNET_1_CIDR="10.10.3.0/24"
$DB_PRIVATE_SUBNET_2_CIDR="10.10.6.0/24"
$CREATE_NATGATEWAY="YES"
$CREATE_PRIVATE_SUBNETS="true"
$NUMBER_AZs="2"
$NAT_ALLOCATION_ID_EIP="" #Esto debe salir de un template que crea EIP

#SHARED


#ROUTE53
$HOSTED_ZONE_NAME="transfors.co"
$HOSTED_ZONE_ID=""
$ENABLE_LOGIN="NO"
$LOG_RETENTION_DAYS="30"

#ELB
$TYPE_ELB="application"
$API_DOMAIN="www.transforsweb.co"

#PARAMETROS RDS
$DB_USERNAME="trannsfor_bd"
$BD_PASSWORD="EKNR?-h8QMPQ+J+8h9epVR%^aY5AepGT"
$CLUSTER_ACTION="CREATE"
$DATABASE_NAME="moradodb"
$ENGINE="13.3"
$CLUSTER_DELETION_PROTECTION="DISABLED"
$CLUSTER_BACKUP_RETENTION_PERIOD="1"
$CLUSTER_INSTANCE_CLASS="db.t3.micro"
$CLUSTER_SNAPSHOT_ARN=""
$DB_SUBDOMAIN_NAME_WITHOUT_DOT="db-dev"
$USE_ENVIROMENT_SUFIX="NO"
$ADD_DNS_RECORDS="NO"

###PARAMETROS STACK MASTER WAF###
$WAF_APP_NAME="API"
$WAF_APP_DEFAULT_ACTION="ALLOW"
$A1_INJECTION='YES'
$A2_BROKEN_AUTHENTICATION="NO"
$A3_CROSS_SITE_SCRIPTING='YES'
$A4_BROKEN_ACCESS_CONTROL='NO'
$A5_SECURITY_MISCONFIGURATION='NO'
$A7_INSUFFICIENT_ATTACK_PROTECTION='YES'
$A8_CROSS_SITE_REQUEST_FORGERY='NO'
$HTTP_FLOOD_PROTECTION="YES - AWS WAF rate based rule"
$MAX_EXPECTED_BODY_SIZE=128000
$MAX_EXPECTED_URI_SIZE=128
$MAX_EXPECTED_QUERY_STRING_SIZE=256
$MAX_EXPECTED_HEADER_AUTORIZATION=1900
$MAX_EXPECTED_HEADER_CSRF=37
$REQUEST_TRESHOLD=200
$WAF_BLOCK_PERIOD=5


$SUPPORT_EMAIL="awsadmin@transfors.com.co"
$ALARMS_EMAIL="awsadmin@transfors.com.co"

$HOSTED_ZONE=""
# $HOSTED_ZONE="Z05944852T4H5WX5BHJ6K"
# $CERTIFICATE=""
$CERTIFICATE="arn:aws:acm:us-east-1:573128502780:certificate/d56e45af-c886-4021-9677-5ffb2152a8b8"
$CERTIFICATE2="arn:aws:acm:us-east-1:573128502780:certificate/d56e45af-c886-4021-9677-5ffb2152a8b8"
$CERTIFICATE3="arn:aws:acm:us-east-1:573128502780:certificate/2a0282cc-6f0c-4d6f-a707-111ddc1d4402"
$AUTH_DOMAIN=""
# $AUTH_DOMAIN="auth.lapositivapruebas.applying.pe"