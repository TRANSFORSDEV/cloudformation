from crhelper import CfnResource
import logging
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
    logger.info(event)
    helper(event, context)


@helper.create
def create(event, context):
    logger.info("Got Create")
    try:
        put_logging_configuration(logger, event['ResourceProperties']['WAFWebACLArn'],
                                  event['ResourceProperties']['DeliveryStreamArn'])
    except Exception as e:
        logger.error('Signaling failure to CloudFormation.')
        logger.error(e)


@helper.update
def update(event, context):
    logger.info("Got Update")
    try:
        delete_logging_configuration(logger, event['OldResourceProperties']['WAFWebACLArn'])
        put_logging_configuration(logger, event['ResourceProperties']['WAFWebACLArn'],
                                  event['ResourceProperties']['DeliveryStreamArn'])
    except Exception as e:
        logger.error('Signaling failure to CloudFormation.')
        logger.error(e)


@helper.delete
def delete(event, context):
    try:
        delete_logging_configuration(logger, event['ResourceProperties']['WAFWebACLArn'])
    except Exception as e:
        logger.error('Signaling failure to CloudFormation.')
        logger.error(e)

def put_logging_configuration(log, web_acl_arn, delivery_stream_arn):
    log.debug("[waflib:put_logging_configuration] Start")

    try:
        response = client.put_logging_configuration(
            LoggingConfiguration={
                'ResourceArn': web_acl_arn,
                'LogDestinationConfigs': [delivery_stream_arn]
            }
        )
        log.debug("[waflib:put_logging_configuration] End")
        return response
    except Exception as e:
        log.error("Failed to configure log for WebAcl: %s", str(web_acl_arn))
        log.error(str(e))
        log.debug("[waflib:put_logging_configuration] End")
        return None


def delete_logging_configuration(log, web_acl_arn):
    log.debug("[waflib:delete_logging_configuration] Start")

    try:
        response = client.delete_logging_configuration(
            ResourceArn=web_acl_arn
        )
        log.debug("[waflib:delete_logging_configuration] End")
        return response
    except Exception as e:
        log.error("Failed to delete log for WebAcl: %s", str(web_acl_arn))
        log.error(str(e))
        log.debug("[waflib:delete_logging_configuration] End")
        return None


