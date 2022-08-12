$TEMPLATE_FILE='../master-base.yaml'
$PACKAGED_FILE='../output/master-base.packaged.yaml'

mkdir -p ../output

aws cloudformation package `
--template-file $TEMPLATE_FILE `
--s3-bucket $BUCKET `
--s3-prefix $PREFIX/base `
--output-template-file $PACKAGED_FILE `
--profile $AWS_PROFILE `
--region $AWS_REGION

aws s3 cp $PACKAGED_FILE s3://$BUCKET/$PREFIX/base/master-base.packaged.yaml --profile $AWS_PROFILE

$PACKAGED_FILE='../output/master-base.packaged.yaml'