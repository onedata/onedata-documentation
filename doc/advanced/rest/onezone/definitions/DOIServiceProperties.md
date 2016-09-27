
<a name="doiserviceproperties"></a>
### DOIServiceProperties
The properties of a [DOI](http://doi.org) registration service.

*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**allowTemplateOverride**  <br>*optional*|Specifies whether users can override the DOI suffix template for this account during registration of new DOI's.|boolean|
|**doiEndpoint**  <br>*required*|DOI registration API endpoint relative to the host.|string|
|**host**  <br>*required*|The service host, including the protocol.|string|
|**identifierTemplate**  <br>*optional*|The template for generation of new DOI's using this account.|string|
|**mediaEndpoint**  <br>*required*|Media registration API endpoint relative to the host.|string|
|**metadataEndpoint**  <br>*required*|Metadata registration API endpoint relative to the host.|string|
|**password**  <br>*required*|The password for login to the DOI service.|string|
|**prefix**  <br>*required*|The DOI prefix under which new DOI's can be minted using this account.|string|
|**type**  <br>*required*|The type of handle service.|enum (DOI, PID)|
|**username**  <br>*required*|The username for login to the DOI service.|string|



