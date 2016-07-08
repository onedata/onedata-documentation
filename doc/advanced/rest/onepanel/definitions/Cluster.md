
<a name="cluster"></a>
### Cluster
Generic type for Onedata service cluster definition.


|Name|Description|Schema|
|---|---|---|
|**databases**  <br>*optional*||[databases](#cluster-databases)|
|**domainName**  <br>*optional*|Domain name of the service.|string|
|**managers**  <br>*optional*||[managers](#cluster-managers)|
|**nodes**  <br>*optional*||< string, [nodes](#cluster-nodes) > map|
|**type**  <br>*optional*|Type of Onedata service|enum (onezone, oneprovider)|
|**workers**  <br>*optional*||[workers](#cluster-workers)|

<a name="cluster-databases"></a>
**databases**

|Name|Description|Schema|
|---|---|---|
|**nodes**  <br>*optional*||< string > array|

<a name="cluster-managers"></a>
**managers**

|Name|Description|Schema|
|---|---|---|
|**items**  <br>*optional*||< string > array|
|**mainNode**  <br>*optional*|The Id of the main cluster manager node.|string|

<a name="cluster-nodes"></a>
**nodes**

|Name|Description|Schema|
|---|---|---|
|**hostname**  <br>*optional*|Node hostname|string|

<a name="cluster-workers"></a>
**workers**

|Name|Description|Schema|
|---|---|---|
|**nodes**  <br>*optional*||< string > array|



