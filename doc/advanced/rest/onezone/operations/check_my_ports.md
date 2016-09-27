
<a name="check_my_ports"></a>
#### Check ports availability
```
POST /provider/test/check_my_ports
```


##### Description
Checks if all given ports are reachable from Onezone. 

This operation has public access.

***Example cURL requests***

**Check provider ports**
```bash
curl -i --tlsv1.2 -X POST -H 'Content-type: application/json' \
-d '[ 80 ]' https://$HOST:8443/api/v3/onezone/provider/test/check_my_ports
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**ports**  <br>*optional*|List of ports to check.|< string > array|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the list of ports (with URLs) and their status.|< < string > array > array|
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
"/provider/test/check_my_ports"
```


###### Request body
```
json :
[ "https://provider1.com:80", "https://provider1.com:443" ]
```


##### Example HTTP response

###### Response 200
```
json :
"array"
```


###### Response 400
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 401
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



