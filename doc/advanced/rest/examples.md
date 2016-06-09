# REST API examples

This sections presents example invocations of various Onedata REST interfaces.


## Command line examples
Command line examples are based on the [HTTPie](http://httpie.org) command line HTTP client. 

### Onezone

#### Authenticate to Onezone service
```bash
http POST 
```

#### Get and modify user details
```bash
> http GET https://beta.onedata.org/api/v3/onezone/user
{
    "alias": "John Doe",
    "connectedAccounts": [
        {
            "accountId": "ASD879ASD-7SADASFSsa0831",
            "providerId": "7YASBFLJ-123ASD870-ASDASD"
        }
    ],
    "emailList": [
        "rudolf.linges@example.com"
    ],
    "name": "Rudolf Lingens",
    "userId": "ALKJSDH77i79ASDKJA-ASDBAS9-87"
}
```

#### Create new space and invite another user
```
```

#### Create new group and invite another user

#### Accept invitation to a space from another user

### Oneprovider


### Onepanel

