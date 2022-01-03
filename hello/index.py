def lambda_handler(event, context):
    if event.get('queryStringParameters') and event['queryStringParameters'].get('name'):
        return {
            'statusCode': 200,
            'body': 'Hello, ' + event['queryStringParameters']['name'] + '!'
        }
    else:
        return {
            'statusCode': 200,
            'body': 'ho-ho-ho'
        }
