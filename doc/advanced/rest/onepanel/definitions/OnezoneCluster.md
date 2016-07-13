
<a name="onezonecluster"></a>
### OnezoneCluster
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**databases**  <br>*required*||[databases](#onezonecluster-databases)|
|**domainName**  <br>*required*|Domain name of the service.|string|
|**managers**  <br>*required*||[managers](#onezonecluster-managers)|
|**nodes**  <br>*required*||< string, [nodes](#onezonecluster-nodes) > map|
|**type**  <br>*required*|Type of Onedata service|enum (onezone, oneprovider)|
|**workers**  <br>*required*||[workers](#onezonecluster-workers)|

<a name="onezonecluster-databases"></a>
**databases**

|Name|Description|Schema|
|---|---|---|
|**nodes**  <br>*required*||< string > array|

<a name="onezonecluster-managers"></a>
**managers**

|Name|Description|Schema|
|---|---|---|
|**items**  <br>*required*||< string > array|
|**mainNode**  <br>*required*|The Id of the main cluster manager node.|string|

<a name="onezonecluster-nodes"></a>
**nodes**

|Name|Description|Schema|
|---|---|---|
|**hostname**  <br>*required*|Node hostname|string|

<a name="onezonecluster-workers"></a>
**workers**

|Name|Description|Schema|
|---|---|---|
|**nodes**  <br>*required*||< string > array|



