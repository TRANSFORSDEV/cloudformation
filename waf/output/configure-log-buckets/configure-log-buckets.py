from crhelper import CfnResource
import logging
import os
from os import environ, remove
import boto3
from botocore.config import Config

logger = logging.getLogger(__name__)

logger.info("pass import")

helper = CfnResource(
    json_logging=False,
    log_level=str(environ['LOG_LEVEL'].upper()),
    boto_level='CRITICAL'
)

logger.info("pass helper")

logger.info("pass boto client")

lambda_partition_s3_logs_function = None
lambda_parser = None
athena_parser = None
lambda_log_parser_function = None
bucket_log_prefix = None


def handler(event, context):
    logger.info("on handler")
    try:
        logger.info(event)
    except Exception as e:
        logger.error(e)

    global lambda_log_parser_function
    global lambda_partition_s3_logs_function
    global lambda_parser
    global athena_parser
    global bucket_log_prefix

    lambda_log_parser_function = event['ResourceProperties']['LogParser'] \
        if 'LogParser' in event['ResourceProperties'] \
        else None
    bucket_log_prefix = event['ResourceProperties']['BucketLogPrefix'] \
        if 'BucketLogPrefix' in event['ResourceProperties'] \
        else None

    if event['ResourceType'] == "Custom::ConfigureAppAccessLogBucket":
        lambda_partition_s3_logs_function = event['ResourceProperties']['MoveS3LogsForPartition'] \
            if 'MoveS3LogsForPartition' in event['ResourceProperties'] \
            else None
        lambda_parser = True if event['ResourceProperties']['ScannersProbesLambdaLogParser'] == 'yes' else False
        # athena_parser = True if event['ResourceProperties']['ScannersProbesAthenaLogParser'] == 'yes' else False
    else:
        lambda_partition_s3_logs_function = None
        lambda_parser = True if event['ResourceProperties']['HttpFloodLambdaLogParser'] == 'yes' else False
        # athena_parser = True if event['ResourceProperties']['HttpFloodAthenaLogParser'] == 'yes' else False

    helper(event, context)


@helper.create
def create(event, context):
    logger.info("Got Create")
    try:
        if event['ResourceType'] == "Custom::ConfigureAppAccessLogBucket":
            add_s3_bucket_lambda_event(logger,
                                       event['ResourceProperties']['AppAccessLogBucket'],
                                       lambda_log_parser_function,
                                       lambda_partition_s3_logs_function,
                                       lambda_parser,
                                       athena_parser)
        elif event['ResourceType'] == "Custom::ConfigureWafLogBucket":
            add_s3_bucket_lambda_event(logger,
                                       event['ResourceProperties']['WafLogBucket'],
                                       lambda_log_parser_function,
                                       lambda_partition_s3_logs_function,
                                       lambda_parser,
                                       athena_parser)
        else:
            pass
    except Exception as e:
        logger.error('Signaling failure to CloudFormation.')
        logger.error(e)


@helper.update
def update(event, context):
    logger.info("Got Update")
    try:
        if event['ResourceType'] == "Custom::ConfigureAppAccessLogBucket":
            old_lambda_app_log_parser_function = event['OldResourceProperties']['LogParser'] \
                if 'LogParser' in event['OldResourceProperties'] \
                else None
            old_lambda_partition_s3_logs_function = event['OldResourceProperties']['MoveS3LogsForPartition'] \
                if 'MoveS3LogsForPartition' in event['OldResourceProperties'] \
                else None
            old_lambda_parser = True \
                if event['OldResourceProperties']['ScannersProbesLambdaLogParser'] == 'yes' \
                else False
            old_athena_parser = True \
                if event['OldResourceProperties']['ScannersProbesAthenaLogParser'] == 'yes' \
                else False

            if (event['OldResourceProperties']['AppAccessLogBucket'] != event['ResourceProperties'][
                'AppAccessLogBucket'] or
                    old_lambda_app_log_parser_function != lambda_log_parser_function or
                    old_lambda_partition_s3_logs_function != lambda_partition_s3_logs_function or
                    old_lambda_parser != lambda_parser or
                    old_athena_parser != athena_parser):
                remove_s3_bucket_lambda_event(logger, event['OldResourceProperties']["AppAccessLogBucket"],
                                              old_lambda_app_log_parser_function,
                                              old_lambda_partition_s3_logs_function)
                add_s3_bucket_lambda_event(logger, event['ResourceProperties']['AppAccessLogBucket'],
                                           lambda_log_parser_function,
                                           lambda_partition_s3_logs_function,
                                           lambda_parser,
                                           athena_parser)
        elif event['ResourceType'] == "Custom::ConfigureWafLogBucket":
            print('1')
            old_lambda_app_log_parser_function = event['OldResourceProperties']['LogParser'] if 'LogParser' in \
                                                                                                event[
                                                                                                    'OldResourceProperties'] else None
            old_lambda_parser = True if event['OldResourceProperties'][
                                            'HttpFloodLambdaLogParser'] == 'yes' else False
            old_athena_parser = True if event['OldResourceProperties'][
                                            'HttpFloodAthenaLogParser'] == 'yes' else False

            if (event['OldResourceProperties']['WafLogBucket'] != event['ResourceProperties']['WafLogBucket'] or
                    old_lambda_app_log_parser_function != lambda_log_parser_function or
                    old_lambda_parser != lambda_parser or
                    old_athena_parser != athena_parser):

                print('2')
                remove_s3_bucket_lambda_event(logger, event['OldResourceProperties']["WafLogBucket"],
                                              old_lambda_app_log_parser_function,
                                              lambda_partition_s3_logs_function)
                add_s3_bucket_lambda_event(logger, event['ResourceProperties']['WafLogBucket'],
                                           lambda_log_parser_function,
                                           lambda_partition_s3_logs_function,
                                           lambda_parser,
                                           athena_parser)
            print('2')
        else:
            pass
    except Exception as e:
        logger.error('Signaling failure to CloudFormation.')
        logger.error(e)


@helper.delete
def delete(event, context):
    try:
        if event['ResourceType'] == "Custom::ConfigureAppAccessLogBucket":
            remove_s3_bucket_lambda_event(log, event['ResourceProperties']["AppAccessLogBucket"],
                                          lambda_log_parser_function, lambda_partition_s3_logs_function)
        elif event['ResourceType'] == "Custom::ConfigureWafLogBucket":
            remove_s3_bucket_lambda_event(log, event['ResourceProperties']["WafLogBucket"],
                                          lambda_log_parser_function,
                                          lambda_partition_s3_logs_function)
        else:
            pass
    except Exception as e:
        logger.error('Signaling failure to CloudFormation.')
        logger.error(e)


def add_s3_bucket_lambda_event(log, bucket_name, lambda_function_arn, lambda_log_partition_function_arn, lambda_parser,
                               athena_parser):
    log.info("[add_s3_bucket_lambda_event] Start")
    print('$$bucket_name:'+bucket_name)
    print('$$lambda_function_arn:'+lambda_function_arn)
    # print('$$lambda_log_partition_function_arn:'+lambda_log_partition_function_arn)
    print('$$lambda_parser:'+str(lambda_parser))

    try:
        s3_client = boto3.client('s3')
        if lambda_function_arn is not None and (lambda_parser or athena_parser):
            notification_conf = s3_client.get_bucket_notification_configuration(Bucket=bucket_name)

            log.info("[add_s3_bucket_lambda_event] notification_conf:\n %s"
                     % (notification_conf))

            new_conf = {}
            new_conf['LambdaFunctionConfigurations'] = []

            if 'TopicConfigurations' in notification_conf:
                new_conf['TopicConfigurations'] = notification_conf['TopicConfigurations']

            if 'QueueConfigurations' in notification_conf:
                new_conf['QueueConfigurations'] = notification_conf['QueueConfigurations']

            if lambda_parser:
                new_conf['LambdaFunctionConfigurations'].append({
                    'Id': 'Call Log Parser',
                    'LambdaFunctionArn': lambda_function_arn,
                    'Events': ['s3:ObjectCreated:*'],
                    'Filter': {'Key': {'FilterRules': [{'Name': 'suffix', 'Value': 'gz'}]}}
                })

            if athena_parser:
                new_conf['LambdaFunctionConfigurations'].append({
                    'Id': 'Call Athena Result Parser',
                    'LambdaFunctionArn': lambda_function_arn,
                    'Events': ['s3:ObjectCreated:*'],
                    'Filter': {'Key': {'FilterRules': [{'Name': 'prefix', 'Value': 'athena_results/'},
                                                       {'Name': 'suffix', 'Value': 'csv'}]}}
                })

            if lambda_log_partition_function_arn is not None:
                new_conf['LambdaFunctionConfigurations'].append({
                    'Id': 'Call s3 log partition function',
                    'LambdaFunctionArn': lambda_log_partition_function_arn,
                    'Events': ['s3:ObjectCreated:*'],
                    'Filter': {'Key': {
                        'FilterRules': [{'Name': 'prefix', 'Value': 'AWSLogs/'}, {'Name': 'suffix', 'Value': 'gz'}]}}
                })

            log.info("[add_s3_bucket_lambda_event] LambdaFunctionConfigurations:\n %s"
                     % (new_conf['LambdaFunctionConfigurations']))

            s3_client.put_bucket_notification_configuration(Bucket=bucket_name, NotificationConfiguration=new_conf)
    except Exception as error:
        log.error(error)

    log.info("[add_s3_bucket_lambda_event] End")


def remove_s3_bucket_lambda_event(log, bucket_name, lambda_function_arn, lambda_log_partition_function_arn):
    if lambda_function_arn != None:
        log.info("[remove_s3_bucket_lambda_event] Start")

        s3_client = boto3.client('s3')
        try:
            new_conf = {}
            notification_conf = s3_client.get_bucket_notification_configuration(Bucket=bucket_name)

            log.info("[remove_s3_bucket_lambda_event]notification_conf:\n %s"
                     % (notification_conf))

            if 'TopicConfigurations' in notification_conf:
                new_conf['TopicConfigurations'] = notification_conf['TopicConfigurations']
            if 'QueueConfigurations' in notification_conf:
                new_conf['QueueConfigurations'] = notification_conf['QueueConfigurations']

            if 'LambdaFunctionConfigurations' in notification_conf:
                new_conf['LambdaFunctionConfigurations'] = []
                for lfc in notification_conf['LambdaFunctionConfigurations']:
                    if lfc['LambdaFunctionArn'] == lambda_function_arn or \
                            lfc['LambdaFunctionArn'] == lambda_log_partition_function_arn:
                        log.info("[remove_s3_bucket_lambda_event]%s match found, continue." % lfc['LambdaFunctionArn'])
                        continue  # remove all references
                    else:
                        new_conf['LambdaFunctionConfigurations'].append(lfc)
                        log.info("[remove_s3_bucket_lambda_event]lfc appended: %s" % lfc)

            log.info("[remove_s3_bucket_lambda_event]new_conf:\n %s"
                     % (new_conf))

            s3_client.put_bucket_notification_configuration(Bucket=bucket_name, NotificationConfiguration=new_conf)

        except Exception as error:
            log.error(
                "Failed to remove S3 Bucket lambda event. Check if the bucket still exists, you own it and has proper access policy.")
            log.error(str(error))

        log.info("[remove_s3_bucket_lambda_event] End")
