
<a name="filedistribution"></a>
### FileDistribution
Describes distribution of a single file among different storage providers. For each provider, this data type provides a list of byte ranges  (specified as a list of pairs [offset, size]), which describe which blocks of a given file are stored at which provider.

*Type* : < [FileDistribution](#filedistribution-inline) > array

<a name="filedistribution-inline"></a>
**FileDistribution**

|Name|Description|Schema|
|---|---|---|
|**blocks**  <br>*optional*|The list of blocks in byte ranges stored at that provider.|< < integer > array > array|
|**providerId**  <br>*optional*|ID of the provider|string|

**Example**
```
""
```



