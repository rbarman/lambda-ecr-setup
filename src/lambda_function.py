
# load_dotenv() required if manually running the script without docker
# from dotenv import load_dotenv
# load_dotenv()
    
def lambda_handler(event, context):
    print(event)
    return {
        "statusCode": 200,
        "body": {
            "message": "Hello, World!"
        }
    }

if __name__ == "__main__":
    event = {
        
    }
    response = lambda_handler(event, None)
    print(response)
