
<a name="remove_provider"></a>
#### Remove provider
```
DELETE /providers/{pid}
```


##### Description
Removes specific Oneprovider from this zone.

If called by other provider doesn't require any special privileges.

When called by a regular user, requires 'list_providers' privilege.

This operation requires `list_providers` privilege.

***Example cURL requests***

**Get specific provider details**
```bash
curl --cert ozp_cert.pem --key ozp_key.pem -X DELETE  \
https://$HOST:8443/api/v3/onezone/providers/WEavnRE7c49EU2sjF0Rz7l_kpiA1IBrwbDxNfH87Plc
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**pid**  <br>*required*|Provider ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Provider unregistered successfully|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/providers/string"
```


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 401
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 403
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 404
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 500
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```



