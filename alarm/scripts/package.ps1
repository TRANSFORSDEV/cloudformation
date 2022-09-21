$TEMPLATE_FILE='../master-alarm.yaml'
$PACKAGED_FILE='../output/master-alarm.packaged.yaml'

mkdir -p ../output

aws cloudformation package `
--template-file $TEMPLATE_FILE `
--s3-bucket $BUCKET `
--s3-prefix $PREFIX/alarm `
--output-template-file $PACKAGED_FILE `
--profile $AWS_PROFILE `
--region $AWS_REGION

aws s3 cp $PACKAGED_FILE s3://$BUCKET/$PREFIX/alarm/master-alarm.packaged.yaml --profile $AWS_PROFILE

$PACKAGED_FILE='../output/master-alarm.packaged.yaml'