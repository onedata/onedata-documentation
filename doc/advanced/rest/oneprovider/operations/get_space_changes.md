
<a name="get_space_changes"></a>
#### Subscribe to file events
```
GET /changes/metadata/{sid}
```


##### Description
This method subscribes through HTTP streaming on events of specific type for a given space.

Until the connection is kept alive, the events will be streamed to subscribers as soon as they are occur. The optional `timeout` parameter can be used to automatically disconnect  when no events occur in a given time window.

***Example cURL requests***

**Listen to space change events**
```bash
curl --tlsv1.2 -N -X GET -H "X-Auth-Token: $TOKEN" \
"https://$HOST:8443/api/v3/oneprovider/changes/metadata/MySpace1"
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**sid**  <br>*required*|Space ID.|string|--|
|**Query**|**last_seq**  <br>*optional*|Last known file metadata sequence number|integer|--|
|**Query**|**timeout**  <br>*optional*|Optional timeout in milliseconds, which allows to automatically break connection  when no event occured in specified time. By default the timeout is unlimited.|integer|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Subscription to events has been successful.|[FileMetadataChange](../definitions/FileMetadataChange.md#filemetadatachange)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Oneprovider REST API not available.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/changes/metadata/string"
```


###### Request query
```
json :
{
  "last_seq" : 0,
  "timeout" : 0
}
```


##### Example HTTP response

###### Response 200
```
json :
{
  "seq" : 123,
  "file_id" : "4efc4a0c-0a61-4766-8fe9-c3d7fb414da8",
  "file_path" : "/Space1/folder2/file1.txt",
  "name" : "file1.txt",
  "deleted" : false,
  "changes" : [ {
    "type" : "reg",
    "mode" : 511,
    "atime" : 1464958683054,
    "mtime" : 1464958683051,
    "ctime" : 1464958681054,
    "uid" : "f986246a-4d95-46ae-b3b9-e00172767e88",
    "size" : 1024,
    "version" : 1,
    "is_scope" : false,
    "scope" : "a0274289-6f8a-482f-86f8-4a518760749c",
    "xattrs" : [ {
      "name" : "mime_type",
      "value" : "application/text"
    }, {
      "name" : "dc.language",
      "value" : "en"
    }, {
      "name" : "dc.identifier",
      "value" : "doi:10.1002/0470123"
    } ]
  } ]
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



