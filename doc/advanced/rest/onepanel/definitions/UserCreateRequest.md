
<a name="usercreaterequest"></a>
### UserCreateRequest
The user configuration details required for creation process.


|Name|Description|Schema|
|---|---|---|
|**password**  <br>*required*|The user password. It must be at least 8 characters long and contain a minimum of 1 lower case letter [a-z] and a minimum of 1 upper case letter [A-Z] and a minimum of 1 numeric character [0-9]. The Password must not contain a colon character [:].|string|
|**userRole**  <br>*required*|The user role, one of 'admin' or 'regular'.|enum (admin, regular)|
|**username**  <br>*required*|The user name. It must be at least 4 characters long and contain only alphanumeric characters [a-zA-Z0-9].|string|

**Example**
```
{
  "username" : "john",
  "password" : "P@@$$W0RD",
  "userRole" : "admin"
}
```



