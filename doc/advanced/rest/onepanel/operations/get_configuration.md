
<a name="get_configuration"></a>
#### Get deployment configuration
```
GET /configuration
```


##### Description
Returns the configuration of the Onedata deployment managed by Onepanel. Depending on wether this Onepanel
instance manages Onezone or Onepanel service, specific configuration will be returned.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the Onedata service deployment configuration.|[Configuration](../definitions/Configuration.md#configuration)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Oneprovider service configuration is not available.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`
* `application/x-yaml`


##### Example HTTP request

###### Request path
```
json :
"/configuration"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "cluster" : {
    "type" : "string",
    "domainName" : "string",
    "nodes" : {
      "string" : "object"
    },
    "managers" : "object",
    "workers" : "object",
    "databases" : "object"
  }
}
```


###### Response 400
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 403
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 404
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 500
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```



