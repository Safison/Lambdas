# Creating Lambdas with the Console
import boto3
from datetime import datetime

import random
import json
def lambda_handler(event, context):
    # write your solution here
    rand_list = []
    rand_no = random.randint(1,6)  
    for i in range(event['dice_count']):
        rand_list.append(rand_no)
    timestamp = datetime.now()

    result = {'dice_count':rand_list,
              'time_stampe':timestamp}
    result = str(result)
    result_encoded=result.encode('utf-8')

    bucket_name = "random-bucket-12345"
    file_name = f"sprintrandomfile{datetime.now()}.txt"
    s3 = boto3.resource('s3')
    s3.Bucket(bucket_name).put_object(Key=file_name,Body=result_encoded)
