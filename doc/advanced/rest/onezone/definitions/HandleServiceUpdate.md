
<a name="handleserviceupdate"></a>
### HandleServiceUpdate
Handle service instance.


|Name|Description|Schema|
|---|---|---|
|**name**  <br>*optional*|The user defined name of the service.|string|
|**proxyEndpoint**  <br>*optional*|The endpoint of the Handle service proxy, i.e. a service which implements logic specific for particular Handle service.|string|
|**serviceProperties**  <br>*optional*||[HandleServicePropertiesUpdate](HandleServicePropertiesUpdate.md#handleservicepropertiesupdate)|

**Example**
```
{
  "proxyEndpoint" : "https://newendpointdomain.com:17000/handle_proxy"
}
```



