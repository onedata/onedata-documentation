
<a name="cluster"></a>
### Cluster
Generic type for Onedata service cluster definition.


|Name|Description|Schema|
|---|---|---|
|**databases**  <br>*required*||[databases](#cluster-databases)|
|**domainName**  <br>*required*|Domain name of the service.|string|
|**managers**  <br>*required*||[managers](#cluster-managers)|
|**nodes**  <br>*required*||< string, [nodes](#cluster-nodes) > map|
|**type**  <br>*required*|Type of Onedata service|enum (onezone, oneprovider)|
|**workers**  <br>*required*||[workers](#cluster-workers)|

<a name="cluster-databases"></a>
**databases**

|Name|Description|Schema|
|---|---|---|
|**nodes**  <br>*required*||< string > array|

<a name="cluster-managers"></a>
**managers**

|Name|Description|Schema|
|---|---|---|
|**items**  <br>*required*||< string > array|
|**mainNode**  <br>*required*|The Id of the main cluster manager node.|string|

<a name="cluster-nodes"></a>
**nodes**

|Name|Description|Schema|
|---|---|---|
|**hostname**  <br>*required*|Node hostname|string|

<a name="cluster-workers"></a>
**workers**

|Name|Description|Schema|
|---|---|---|
|**nodes**  <br>*required*||< string > array|



