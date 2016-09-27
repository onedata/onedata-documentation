
<a name="doiservicepropertiesupdate"></a>
### DOIServicePropertiesUpdate
The properties of a [DOI](http://doi.org) registration service.

*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**allowTemplateOverride**  <br>*optional*|Specifies whether users can override the DOI suffix template for this account during registration of new DOI's.|boolean|
|**doiEndpoint**  <br>*optional*|DOI registration API endpoint relative to the host.|string|
|**host**  <br>*optional*|The service host, including the protocol.|string|
|**identifierTemplate**  <br>*optional*|The template for generation of new DOI's using this account.|string|
|**mediaEndpoint**  <br>*optional*|Media registration API endpoint relative to the host.|string|
|**metadataEndpoint**  <br>*optional*|Metadata registration API endpoint relative to the host.|string|
|**password**  <br>*optional*|The password for login to the DOI service.|string|
|**prefix**  <br>*optional*|The DOI prefix under which new DOI's can be minted using this account.|string|
|**type**  <br>*required*|The type of handle service.|enum (DOI, PID)|
|**username**  <br>*optional*|The username for login to the DOI service.|string|



