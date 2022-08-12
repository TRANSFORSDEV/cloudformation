from crhelper import CfnResource
import logging
import json
import boto3
from botocore.config import Config

logger = logging.getLogger(__name__)

logger.info("pass import")

helper = CfnResource(
    json_logging=False,
    log_level='DEBUG',
    boto_level='CRITICAL'
)

logger.info("pass helper")

API_CALL_NUM_RETRIES = 5
client = boto3.client('wafv2', config=Config(retries={'max_attempts': API_CALL_NUM_RETRIES}))

logger.info("pass boto client")

def handler(event, context):
    logger.info("on handler")
    try:
        logger.info(event)
    except Exception as e:
        logger.error(e)
    # logger.info(event)
    helper(event, context)


@helper.create
def create(event, context):
    logger.info("Got Create")
    try:
        stack_name = event['ResourceProperties']['StackName']
        request_threshold = int(event['ResourceProperties']['RequestThreshold'])
        block_period = int(event['ResourceProperties']['WAFBlockPeriod'])
        waf_access_log_bucket = event['ResourceProperties']['WafAccessLogBucket']
        generate_waf_log_parser_conf_file(logger, stack_name, request_threshold, block_period,
                                                          waf_access_log_bucket,
                                                          True)
    except Exception as e:
        logger.error('Signaling failure to CloudFormation.')
        logger.error(e)


@helper.update
def update(event, context):
    logger.info("Got Update")
    try:
        stack_name = event['ResourceProperties']['StackName']
        request_threshold = int(event['ResourceProperties']['RequestThreshold'])
        block_period = int(event['ResourceProperties']['WAFBlockPeriod'])
        waf_access_log_bucket = event['ResourceProperties']['WafAccessLogBucket']
        generate_waf_log_parser_conf_file(logger, stack_name, request_threshold, block_period,
                                          waf_access_log_bucket,
                                          False)
    except Exception as e:
        logger.error('Signaling failure to CloudFormation.')
        logger.error(e)

def generate_waf_log_parser_conf_file(log, stack_name, request_threshold, block_period, waf_access_log_bucket,
                                      overwrite):
    log.debug("[generate_waf_log_parser_conf_file] Start")

    local_file = '/tmp/' + stack_name + '-waf_log_conf_LOCAL.json'
    remote_file = stack_name + '-waf_log_conf.json'
    default_conf = {
        'general': {
            'requestThreshold': request_threshold,
            'blockPeriod': block_period,
            'ignoredSufixes': []
        },
        'uriList': {
        }
    }

    if not overwrite:
        try:
            s3 = boto3.resource('s3')
            file_obj = s3.Object(waf_access_log_bucket, remote_file)
            file_content = file_obj.get()['Body'].read()
            remote_conf = json.loads(file_content)

            if 'general' in remote_conf and 'ignoredSufixes' in remote_conf['general']:
                default_conf['general']['ignoredSufixes'] = remote_conf['general']['ignoredSufixes']

            if 'uriList' in remote_conf:
                default_conf['uriList'] = remote_conf['uriList']

        except Exception as e:
            log.debug("[generate_waf_log_parser_conf_file] \tFailed to merge existing conf file data.")
            log.debug(e)

    with open(local_file, 'w') as outfile:
        json.dump(default_conf, outfile)

    s3_client = boto3.client('s3')
    s3_client.upload_file(local_file, waf_access_log_bucket, remote_file, ExtraArgs={'ContentType': "application/json"})

    log.debug("[generate_waf_log_parser_conf_file] End")



