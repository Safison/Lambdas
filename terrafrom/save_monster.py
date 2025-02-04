import urllib3
import logging
import boto3

def lambda_handler(event,context):

    index = event["monster"]
    url = f"https://www.dnd5eapi.co/api/monsters/{index}"


    payload = {}
    headers = {
        'Accept': 'application/json'
        }


    response = urllib3.request("GET", url)

    if response:
        bucket_name = "la-random-bucket-12345"
        file_name = f"monster-{index}.txt"
        s3 = boto3.resource('s3')
        s3.Bucket(bucket_name).put_object(Key=file_name,Body=response.data)
    else:
        #log to cloud watch
        pass
    sprint_logger = logging.getLogger("sprint_logger")
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    file_handler = logging.FileHandler("example.log")
    file_handler.setFormatter(formatter)
    sprint_logger.addHandler(file_handler)
    sprint_logger.setLevel(logging.DEBUG)