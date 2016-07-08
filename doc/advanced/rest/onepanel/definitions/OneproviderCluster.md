
<a name="oneprovidercluster"></a>
### OneproviderCluster
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**databases**  <br>*optional*||[databases](#oneprovidercluster-databases)|
|**domainName**  <br>*optional*|Domain name of the service.|string|
|**managers**  <br>*optional*||[managers](#oneprovidercluster-managers)|
|**nodes**  <br>*optional*||< string, [nodes](#oneprovidercluster-nodes) > map|
|**storages**  <br>*optional*||< string, [Storage](Storage.md#storage) > map|
|**type**  <br>*optional*|Type of Onedata service|enum (onezone, oneprovider)|
|**workers**  <br>*optional*||[workers](#oneprovidercluster-workers)|

<a name="oneprovidercluster-databases"></a>
**databases**

|Name|Description|Schema|
|---|---|---|
|**nodes**  <br>*optional*||< string > array|

<a name="oneprovidercluster-managers"></a>
**managers**

|Name|Description|Schema|
|---|---|---|
|**items**  <br>*optional*||< string > array|
|**mainNode**  <br>*optional*|The Id of the main cluster manager node.|string|

<a name="oneprovidercluster-nodes"></a>
**nodes**

|Name|Description|Schema|
|---|---|---|
|**hostname**  <br>*optional*|Node hostname|string|

<a name="oneprovidercluster-workers"></a>
**workers**

|Name|Description|Schema|
|---|---|---|
|**nodes**  <br>*optional*||< string > array|



