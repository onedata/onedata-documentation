
<a name="create_session"></a>
#### Create Onepanel user session
```
POST /session
```


##### Description
Creates a new Onepanel user session.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The created session details.|[SessionDetails](../definitions/SessionDetails.md#sessiondetails)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/session"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "sessionId" : "i3h2bp4TjPVuOyvXulbW",
  "username" : "someName"
}
```


###### Response 400
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
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



