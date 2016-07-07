
<a name="userdetails"></a>
### UserDetails
Contains user details necessary when creating a new account.


|Name|Description|Schema|
|---|---|---|
|**password**  <br>*required*|User password.|string|
|**userRole**  <br>*required*|User role - currently only 'admin' and 'regular' are supported.  <br>**Default** : `"regular"`|enum (admin, regular)|
|**username**  <br>*required*|User name.|string|

**Example**
```
{
  "username" : "onedatauser",
  "password" : "P@@$$W0RD",
  "userRole" : "admin"
}
```



