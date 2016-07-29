
<a name="providerregistrationrequest"></a>
### ProviderRegistrationRequest
Provider reqistration request.


|Name|Description|Schema|
|---|---|---|
|**csr**  <br>*required*|Certificate Signature Request to generate new certificate for the provider.|string|
|**latitude**  <br>*required*|The geographical latitude of the provider data center location.|number|
|**longitude**  <br>*required*|The geographical longitude of the provider data center location.|number|
|**redirectionPoint**  <br>*required*|The redirection URL for the provider.|string|
|**urls**  <br>*required*|The list of urls where the provider can be reached.|< string > array|

**Example**
```
{
  "urls" : [ "http://beta.onedata.org/provider1", "http://beta.onedata.org/provider2" ],
  "redirectionPoint" : "http://beta.onedata.org/provider2",
  "csr" : "-----BEGIN CERTIFICATE REQUEST-----\nMIIByjCCATMCAQAwgYkxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlh\nMRYwFAYDVQQHEw1Nb3VudGFpbiBWaWV3MRMwEQYDVQQKEwpHb29nbGUgSW5jMR8w\nHQYDVQQLExZJbmZvcm1hdGlvbiBUZWNobm9sb2d5MRcwFQYDVQQDEw53d3cuZ29v\nZ2xlLmNvbTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEApZtYJCHJ4VpVXHfV\nIlstQTlO4qC03hjX+ZkPyvdYd1Q4+qbAeTwXmCUKYHThVRd5aXSqlPzyIBwieMZr\nWFlRQddZ1IzXAlVRDWwAo60KecqeAXnnUK+5fXoTI/UgWshre8tJ+x/TMHaQKR/J\ncIWPhqaQhsJuzZbvAdGA80BLxdMCAwEAAaAAMA0GCSqGSIb3DQEBBQUAA4GBAIhl\n4PvFq+e7ipARgI5ZM+GZx6mpCz44DTo0JkwfRDf+BtrsaC0q68eTf2XhYOsq4fkH\nQ0uA0aVog3f5iJxCa3Hp5gxbJQ6zV6kJ0TEsuaaOhEko9sdpCoPOnRBm2i/XRD2D\n6iNh8f8z0ShGsFqjDgFHyF3o+lUyj+UC6H1QW7bn\n-----END CERTIFICATE REQUEST-----\n",
  "latitude" : 50.0647,
  "longitude" : 19.945
}
```



