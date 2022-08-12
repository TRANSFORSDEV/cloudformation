#!/usr/bin/python3
import os

output_dir = 'output'
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

BUCKET = os.getenv("BUCKET")
PREFIX = f"{os.getenv('PREFIX')}/shared"
TEMPLATE_FILE = "template.yaml"
PACKAGED_FILE = f"{output_dir}/template.packaged.yaml"

aws_package_cmd = f"""
aws cloudformation package \
--template-file {TEMPLATE_FILE} \
--s3-bucket "{BUCKET}" \
--s3-prefix "{PREFIX}" \
--output-template-file {PACKAGED_FILE}
"""

os.system(aws_package_cmd)

aws_load_cmd = f"""
aws s3 cp {PACKAGED_FILE} s3://{BUCKET}/{PREFIX}/template.packaged.yaml
"""

os.system(aws_load_cmd)
