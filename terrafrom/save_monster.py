import requests
import logging

def lamda_handler(event,context):

    name = event["monster"]
    url = f"https://www.dnd5eapi.co/api/monsters/{name}"


    payload = {}
    headers = {
        'Accept': 'application/json'
        }


    response = requests.request("GET", url, headers=headers, data=payload)

    if response:
        #write to s3 bucket
        pass
    else:
        #log to cloud watch
        pass
    sprint_logger = logging.getLogger("sprint_logger")
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    file_handler = logging.FileHandler("example.log")
    file_handler.setFormatter(formatter)
    sprint_logger.addHandler(file_handler)
    sprint_logger.setLevel(logging.DEBUG)
    
    #print(response.text)

    pass