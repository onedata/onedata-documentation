
<a name="onezonecluster"></a>
### OnezoneCluster
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**databases**  <br>*optional*||[databases](#onezonecluster-databases)|
|**domainName**  <br>*optional*|Domain name of the service.|string|
|**managers**  <br>*optional*||[managers](#onezonecluster-managers)|
|**nodes**  <br>*optional*||< string, [nodes](#onezonecluster-nodes) > map|
|**type**  <br>*optional*|Type of Onedata service|enum (onezone, oneprovider)|
|**workers**  <br>*optional*||[workers](#onezonecluster-workers)|

<a name="onezonecluster-databases"></a>
**databases**

|Name|Description|Schema|
|---|---|---|
|**nodes**  <br>*optional*||< string > array|

<a name="onezonecluster-managers"></a>
**managers**

|Name|Description|Schema|
|---|---|---|
|**items**  <br>*optional*||< string > array|
|**mainNode**  <br>*optional*|The Id of the main cluster manager node.|string|

<a name="onezonecluster-nodes"></a>
**nodes**

|Name|Description|Schema|
|---|---|---|
|**hostname**  <br>*optional*|Node hostname|string|

<a name="onezonecluster-workers"></a>
**workers**

|Name|Description|Schema|
|---|---|---|
|**nodes**  <br>*optional*||< string > array|



