
<a name="add_space_index"></a>
#### Create index for space
```
POST /index
```


##### Description
This method allows to create a new index for space.

Indexes allow creating custom views on data which enable efficient searching through data.

Currently indexes are created per space, i.e. the `space_id` query parameter is required.

The operation returns the created index ID in the response `Location` header.

***Example cURL requests***

**Set JSON metadata for file**
```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X POST \
-H "Content-type: application/json" \
-d "@./my_index_1.js"
https://$HOST:8443/api/v1/oneprovider/index?space_id=7f85c115-8631-4602-b7d5-47cd969280a2&name=MyIndex1
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**name**  <br>*optional*|The user friendly name of the index (can be used to assign names to 'smart folders' in the GUI). If not provided, an auto generated name will be assigned.|string|--|
|**Query**|**space_id**  <br>*required*|File or folder path or space id.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Metadata document updated successfully.  <br>**Headers** :   <br>`Location` (string) : The path to the index resource, including it's assigned identifier.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|File not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `text/javascript`


##### Example HTTP request

###### Request path
```
json :
"/index"
```


###### Request query
```
json :
{
  "name" : "string",
  "space_id" : "string"
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



