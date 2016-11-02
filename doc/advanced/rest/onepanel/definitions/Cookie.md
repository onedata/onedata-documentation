
<a name="cookie"></a>
### Cookie
The cookie is a character sequence that is common for all the cluster nodes. If this parameter is not provided, in case of a cluster initialization request, it will be generated, and in case of a cluster extension request the current cookie value will be used. However, if the cluster cookie and the cookie of the host that is about to join the cluster doesn't match there will be a connection error.


|Name|Description|Schema|
|---|---|---|
|**cookie**  <br>*optional*|The cluster cookie.|string|

**Example**
```
{
  "cookie" : "AS2KLJH1231AJSHDKJBC12KS578A3SDA"
}
```



