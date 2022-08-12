$TEMPLATE_FILE='../master-waf.yaml'
$PACKAGED_FILE='../output/master-waf.packaged.yaml'

mkdir -p ../output

$BUILD_DIR = "../output"
$SRC_DIR = "../src"

# BUILD - CONFIGURE WAF LOG FUNCTION
$FUNCTION = "configure-waf-logs"
$FUNCTION_BUILD_DIR = "$BUILD_DIR/$FUNCTION"

Copy-Item -Path "$SRC_DIR/$FUNCTION" -Destination "$FUNCTION_BUILD_DIR" -Recurse -Force
Copy-Item -Path "$SRC_DIR/lib" -Destination $FUNCTION_BUILD_DIR -Recurse -Force
pip install -r "$FUNCTION_BUILD_DIR/requirements.txt" -t $FUNCTION_BUILD_DIR --upgrade

# BUILD - WAF LOG PARSER FUNCTION
$FUNCTION = "log-parser"
$FUNCTION_BUILD_DIR = "$BUILD_DIR/$FUNCTION"

Copy-Item -Path "$SRC_DIR/$FUNCTION" -Destination "$FUNCTION_BUILD_DIR" -Recurse -Force
Copy-Item -Path "$SRC_DIR/lib" -Destination $FUNCTION_BUILD_DIR -Recurse -Force
pip install -r "$FUNCTION_BUILD_DIR/requirements.txt" -t $FUNCTION_BUILD_DIR --upgrade

# BUILD - WAF CONFIGURE LOGS BUCKETS
$FUNCTION = "configure-log-buckets"
$FUNCTION_BUILD_DIR = "$BUILD_DIR/$FUNCTION"

Copy-Item -Path "$SRC_DIR/$FUNCTION" -Destination "$FUNCTION_BUILD_DIR" -Recurse -Force
pip install -r "$FUNCTION_BUILD_DIR/requirements.txt" -t $FUNCTION_BUILD_DIR --upgrade

# BUILD - WAF GENERATE WAF CONF FILE
$FUNCTION = "generate-waf-conf-file"
$FUNCTION_BUILD_DIR = "$BUILD_DIR/$FUNCTION"

Copy-Item -Path "$SRC_DIR/$FUNCTION" -Destination "$FUNCTION_BUILD_DIR" -Recurse -Force
pip install -r "$FUNCTION_BUILD_DIR/requirements.txt" -t $FUNCTION_BUILD_DIR --upgrade

aws cloudformation package `
--template-file $TEMPLATE_FILE `
--s3-bucket "$BUCKET" `
--s3-prefix "$PREFIX" `
--output-template-file $PACKAGED_FILE `
--profile "$AWS_PROFILE" `
--region "$AWS_REGION"

aws s3 cp $PACKAGED_FILE s3://$BUCKET/$PREFIX/waf/master-waf.packaged.yaml --profile $AWS_PROFILE