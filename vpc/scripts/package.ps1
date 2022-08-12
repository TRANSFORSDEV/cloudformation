$TEMPLATE_FILE='../master-vpc.yaml'
$PACKAGED_FILE='../output/master-vpc.packaged.yaml'

mkdir -p ../output

aws cloudformation package `
--template-file $TEMPLATE_FILE `
--s3-bucket $BUCKET `
--s3-prefix $PREFIX/vpc `
--output-template-file $PACKAGED_FILE `
--profile $AWS_PROFILE `
--region $AWS_REGION

aws s3 cp $PACKAGED_FILE s3://$BUCKET/$PREFIX/vpc/master-vpc.packaged.yaml --profile $AWS_PROFILE

$PACKAGED_FILE='../output/master-vpc.packaged.yaml'