
<a name="modify_configuration"></a>
#### Update configuration
```
PUT /configuration
```


##### Description
Updates the current configuration of Onedata service deployment. Depending on the type of service
managed by the Onepanel, it accepts either Onezone or Oneprovider configuration description.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**configuration**  <br>*required*|New deployment configuration.|[Configuration](../definitions/Configuration.md#configuration)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Onedata service configuration updated successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Onepanel service is not available.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/x-yaml`


##### Example HTTP request

###### Request path
```
json :
"/configuration"
```


###### Request body
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


##### Example HTTP response

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



