#!/bin/bash
## APPLYING TEST
export BUCKET="cf-templates-applying-la-positiva"
export PREFIX="raf/dev/1.0.0"
export AWS_PROFILE="apl-tst" #"appl-tst"
export AWS_REGION="us-east-1"

export COID="LPSTV"
export ASSETID="0004"
export APID="RAF"
export SID="RAFD"
export ENV="DEV"
export VPC="vpc-861049fc"
export PUBLIC_SUBNET="subnet-a93d30ce\,subnet-30fef61e"
export PRIVATE_SUBNET="subnet-07323e7247d8c3858,subnet-0c0395a473cf48a76"

export SUPPORT_EMAIL="john.velasquez@applying.pe"
export ALARMS_EMAIL="john.velasquez@applying.pe"

export MQ_HOST="app3.susalud.gob.pe"
export MQ_PORT="21435"
export MQ_CHANNEL="CH.BRKR.AFCORE20006"
export MQ_QMGR="QM.9999.CORE.AF.20006"
export MQ_QUEUE_NAME_IN="QL.999.AF.005.REQ"
export MQ_QUEUE_NAME_OUT="QL.999.AF.005.RES"


export MQ_USERNAME="applying"
export MQ_PASSWORD="4ppl1ngP@ssW0rd2021"
export MQ_INSTANCE_TYPE="mq.t3.micro"
export MQ_ENGINE_TYPE="RABBITMQ"
export MQ_DEPLOYMENT_MODE="SINGLE_INSTANCE"

export HOSTED_ZONE="Z05944852T4H5WX5BHJ6K"
export CERTIFICATE="arn:aws:acm:us-east-1:851006405034:certificate/8867239e-e49e-4a4d-bb28-3bd549c6a1e7"
export AUTH_DOMAIN="authdev-raf"
export API_DOMAIN="apidev.lapositivapruebas.applying.pe"

export AZURE_METADATA_URL="https://login.microsoftonline.com/fa8f0a04-baaa-49db-970a-05a0432e17a0/federationmetadata/2007-06/federationmetadata.xml?appid=4ec45775-338b-4a2f-8084-58e2a9124481"