
<a name="oneprovidercluster"></a>
### OneproviderCluster
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**databases**  <br>*required*||[databases](#oneprovidercluster-databases)|
|**domainName**  <br>*required*|Domain name of the service.|string|
|**managers**  <br>*required*||[managers](#oneprovidercluster-managers)|
|**nodes**  <br>*required*||< string, [nodes](#oneprovidercluster-nodes) > map|
|**storages**  <br>*optional*||< string, [Storage](Storage.md#storage) > map|
|**type**  <br>*required*|Type of Onedata service|enum (onezone, oneprovider)|
|**workers**  <br>*required*||[workers](#oneprovidercluster-workers)|

<a name="oneprovidercluster-databases"></a>
**databases**

|Name|Description|Schema|
|---|---|---|
|**nodes**  <br>*required*||< string > array|

<a name="oneprovidercluster-managers"></a>
**managers**

|Name|Description|Schema|
|---|---|---|
|**items**  <br>*required*||< string > array|
|**mainNode**  <br>*required*|The Id of the main cluster manager node.|string|

<a name="oneprovidercluster-nodes"></a>
**nodes**

|Name|Description|Schema|
|---|---|---|
|**hostname**  <br>*required*|Node hostname|string|

<a name="oneprovidercluster-workers"></a>
**workers**

|Name|Description|Schema|
|---|---|---|
|**nodes**  <br>*required*||< string > array|



