
<a name="userdetailsresponse"></a>
### UserDetailsResponse
Contains existing user details.


|Name|Description|Schema|
|---|---|---|
|**userRole**  <br>*required*|User role - currently only 'admin' and 'regular' are supported.  <br>**Default** : `"regular"`|enum (admin, regular)|
|**username**  <br>*required*|User name.|string|

**Example**
```
{
  "username" : "onedatauser",
  "userRole" : "admin"
}
```



