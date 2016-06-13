# Python Onedata client REST examples
This page describes how to use the Swagger specification of Onedata service to generate and use clients in most popular programming languages. Example is presented using Python3.

## Setup
First step is to generate the client for appropriate Onedata service using default Swagger generators. Each Onedata service has a separate Swagger REST specification in JSON:
* [Onezone Swagger file](../../swagger/onezone/swagger.json)
* [Oneprovider Swagger file](../../swagger/oneprovider/swagger.json)

### Generating Onedata clients in web browser

Go to [Swagger Editor](http://editor.swagger.io/) and use it's `File->Import URL...` menu to import selected swagger specification.

After it's loaded simply go to `Generate client` menu and selected the language of your choosing

### Generating Onedata clients using Swagger command line tools

Install [Swagger Codegen](https://github.com/swagger-api/swagger-codegen) tool and run (to generate Python client):
```bash
echo '{"packageName": "Onezone", "packageVersion": "3.0.0-beta6"}' > config-python.json
swagger-codegen generate -i ./swagger.json -l python -o python --config config-python.json
```

## Using Onedata clients
Below is an example of a Python 3 Onezone client which uses code directly generated with the `swagger-codegen` command line tool.

```python
#!/usr/local/bin/python3

from Onezone import ApiClient
from Onezone import GroupApi
from Onezone import UserApi
from Onezone import SpaceApi
from Onezone import ProviderApi
from Onezone.models import Space
from Onezone.configuration import Configuration
from Onezone.rest import ApiException

# Specify hostname
HOST='beta.onedata.org'

# Create actual REST API endpoint
REST_ENDPOINT = 'https://'+HOST+':8443/api/v3/onezone'


# Only necessary when connecting to a private Onezone instance
Configuration().verify_ssl = False


# Uncomment to use APIKEY authentication
ACCESSTOKEN = 'MDAxNWxvY2FASDEG9uZXpvbmUKMDAzYmlkZW50aWZpZXIgc0YzTnYzUGdNdURxUWgtZEU5eU1PMVpqZEs4TXpheXc0SWRtVWhnUmVFbwowMDFhY2lkIHRpbWUgPCAxNDk3MDE4NjgyCjAwMmZzaWduYXR1cmUgccFjygoeDwuyKXa71ZzfJggJOjbObbSo_0fHc83THHcK'
onezone_client = ApiClient(host=REST_ENDPOINT, header_name='macaroon', header_value=ACCESSTOKEN)

# Uncomment to use username:password authentication
# USERNAME=''
# PASSWORD=''
# Configuration().username = USERNAME
# Configuration().password = PASSWORD
# onezone_client = ApiClient(host=REST_ENDPOINT)

user_api = UserApi(onezone_client)

#
# Create new access token (returns object of type )
#
try:
    result = user_api.get_client_token()
except ApiException as error:
    print("Failed to generate access token: {0} {1}".format(error.status, error.reason))
else:
    print("Generated new access token:\n")
    print(result)

#
# Get user details (returns object of type User)
#
try:
    result = user_api.get_user()
except ApiException as error:
    print("Failed to get user information: {0} {1}".format(error.status, error.reason))
else:
    print("Got user details:\n")
    print(result.name)

#
# Create new space (accepts object of type Space)
#
new_space = Space()
new_space.name = ""
try:
    result = user_api.create_user_space(space=new_space)
except ApiException as error:
    print("Failed to create new space: {0} {1}".format(error.status, error.reason))
else:
    print("Created new space")

#
# List user spaces and get the name of default space
#
try:
    result = user_api.get_user_spaces()
    default_space = user_api.get_user_space(sid=result.default)
except ApiException as error:
    print("Failed to list user spaces: {0} {1}".format(error.status, error.reason))
else:
    print(result)
    print("Default user space is: {0}".format(default_space.name))
```
