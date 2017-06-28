
<a name="get_provider_configuration"></a>
#### Get provider cluster configuration
```
GET /provider/configuration
```


##### Description
Returns the provider cluster configuration.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The provider cluster configuration.|[ProviderConfigurationDetails](../definitions/ProviderConfigurationDetails.md#providerconfigurationdetails)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/configuration"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "cluster" : {
    "manager" : {
      "mainHost" : "node1.oneprovider.onedata.example.com",
      "hosts" : [ "node1.oneprovider.onedata.example.com" ]
    },
    "worker" : {
      "hosts" : [ "node1.oneprovider.onedata.example.com" ]
    },
    "database" : {
      "hosts" : [ "node1.oneprovider.onedata.example.com" ]
    }
  },
  "oneprovider" : {
    "name" : "example"
  }
}
```


###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



