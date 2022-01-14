from requests.models import Response
from hello import __version__
import os
import requests

def send_api_request():
    base_url = os.getenv('BASE_URL').strip('"')
    auth_token = "Bearer " + os.getenv('API_KEY')
    return requests.get(
        f'{base_url}/hello',
        headers={
            "Authorization": auth_token,
            "Content-Type": "application/json",
        }
    )

def test_version():
    assert __version__ == '0.1.0'

def test_api_response_200():
    assert send_api_request().status_code == 200

def test_api_response_message():
    assert send_api_request().content == b'{"message": "Hello, World!"}'