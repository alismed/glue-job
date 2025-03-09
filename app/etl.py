import logging
import boto3
import time

# Configure logger
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Configure CloudWatch
client = boto3.client('logs', region_name='us-east-1')
log_group_name = '/aws-glue/jobs/logs'
log_stream_name = 'glue-job-log-stream'

# Create log group if it doesn't exist
try:
    client.create_log_group(logGroupName=log_group_name)
except client.exceptions.ResourceAlreadyExistsException:
    pass

# Create log stream if it doesn't exist
try:
    client.create_log_stream(
        logGroupName=log_group_name,
        logStreamName=log_stream_name
    )
except client.exceptions.ResourceAlreadyExistsException:
    pass


def send_log_to_cloudwatch(message):
    response = client.describe_log_streams(
        logGroupName=log_group_name,
        logStreamNamePrefix=log_stream_name
    )
    sequence_token = response['logStreams'][0].get('uploadSequenceToken', None)

    log_event = {
        'logGroupName': log_group_name,
        'logStreamName': log_stream_name,
        'logEvents': [
            {
                'timestamp': int(round(time.time() * 1000)),
                'message': message
            }
        ]
    }

    if sequence_token:
        log_event['sequenceToken'] = sequence_token

    client.put_log_events(**log_event)


msg = "Hello, Glue World!"
logger.info(msg)
send_log_to_cloudwatch(msg)
