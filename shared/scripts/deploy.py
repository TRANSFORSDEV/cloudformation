#!/usr/bin/python3
import os

output_dir = 'output'

BUCKET = os.getenv("BUCKET", '')
PREFIX = f"{os.getenv('PREFIX', '')}/shared"
TEMPLATE_FILE = "template.yaml"
PACKAGED_FILE = f"{output_dir}/template.packaged.yaml"
COID = os.getenv("COID", '')
ASSETID = os.getenv("ASSETID", '')
APID = os.getenv("APID", '')
SID = os.getenv("SID", '')
STACK_NUMBER = os.getenv("STACK_NUMBER", '00')
ENV = os.getenv("ENV", '')
VPC = os.getenv("VPC", '')
SUPPORT_EMAIL = os.getenv("SUPPORT_EMAIL", '')

if not os.path.exists(output_dir):
    os.makedirs(output_dir)

aws_deploy_cmd = f"""
aws cloudformation deploy \
--template-file "{PACKAGED_FILE}" \
--stack-name "{COID}-{ASSETID}-{APID}-{SID}-ST-{STACK_NUMBER}-MASTER-SHARED" \
--parameter-overrides \
  StackNumber={STACK_NUMBER} \
  BaseStack="{COID}-{ASSETID}-{APID}-{SID}-ST-{STACK_NUMBER}-MASTER-BASE" \
--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--tags APID={APID} ASSETID={ASSETID} COID={COID} ENV={ENV} SID={SID}
"""

returned_value = os.system(aws_deploy_cmd)
