from requests.models import Response
from hello import __version__
import os
import requests
import subprocess

def setup_module(module):
    setup_credentials()

def test_version():
    assert __version__ == '0.1.0'

def test_api_response_200():
    assert send_api_request().status_code == 200

def test_api_response_message():
    assert send_api_request().content == b'{"message": "Hello, World!"}'

def send_api_request():
    base_url = os.getenv('BASE_URL')
    auth_token = "Bearer " + os.getenv('HELLO_API_KEY')
    return requests.get(
        f'{base_url}/hello',
        headers={
            "Authorization": auth_token,
            "Content-Type": "application/json",
        }
    )

def setup_credentials():
    os.environ['HELLO_API_KEY'] = subprocess.check_output('./set_api_key.sh', shell=True).decode().strip()
    os.environ['BASE_URL'] = subprocess.check_output('terraform output -raw base_url', shell=True).decode().strip()