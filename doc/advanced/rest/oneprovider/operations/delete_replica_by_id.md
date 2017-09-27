
<a name="delete_replica_by_id"></a>
#### Remove existing replica by file ID
```
DELETE /replicas-id/{fid}
```


##### Description
Removes a specific replica of a file - which is hosted by this Oneprovider.
This operation is asynchronous. Optional argument `migration_provider_id`
can be used to specify where the repliace has to be replicated before being
removed from this provider.

If the path specifies a folder, entire folder is removed from
this provider requested provider.

***Example cURL requests***

**Remove file replica by ID from specific storage provider**
```bash
curl --tlsv1.2 -X DELETE -H "X-Auth-Token: $TOKEN" -H 'Content-type: application/json' \
"https://$HOST:8443/api/v3/oneprovider/replicas-id/5d071d11-d355-4918-ade3-dd255b91547d?provider_id=7a0d2c4d-aa00-43df-9e96-cac98b2816bb"


{ "transferId": "b3c85b99-44db-4277-8c66-2ccd50888565" }
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**fid**  <br>*required*|ID of the file.|string|--|
|**Query**|**migration_provider_id**  <br>*optional*|The ID of the provider to which the file should be replicated before being deleted.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The replica removal has been accepted is the transfer ID, which can be used for monitoring of the transfer status.|[Response 200](#delete_replica_by_id-response-200)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Oneprovider REST API not available.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|

<a name="delete_replica_by_id-response-200"></a>
**Response 200**

|Name|Description|Schema|
|---|---|---|
|**transferId**  <br>*optional*|Transfer ID.|string|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/replicas-id/string"
```


###### Request query
```
json :
{
  "migration_provider_id" : "string"
}
```


##### Example HTTP response

###### Response 200
```
json :
"object"
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



