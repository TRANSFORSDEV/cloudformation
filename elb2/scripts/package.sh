#!/bin/bash
TEMPLATE_FILE='../master-elb.yaml'
PACKAGED_FILE='../output/master-elb.packaged.yaml'

WORK_DIR=$(pwd) || exit

# build custom resources
cd ../custom-resources/s3-put-notification || exit
source build.sh || exit
cd "$WORK_DIR" || exit

mkdir -p ../output  || exit

aws cloudformation package \
--template-file $TEMPLATE_FILE \
--s3-bucket "$BUCKET" \
--s3-prefix "$PREFIX/elb" \
--output-template-file $PACKAGED_FILE

aws s3 cp $PACKAGED_FILE s3://$BUCKET/$PREFIX/elb/master-elb.packaged.yaml