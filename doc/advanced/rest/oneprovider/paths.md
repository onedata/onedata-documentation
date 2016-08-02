
<a name="paths"></a>
## Paths

<a name="data_resource"></a>
### Data
Space and file related operations


|Path|Method|Description|
|---|---|---|
|[/attributes/{path}](operations/get_file_attributes.md)|GET|Get file attributes|
|[/attributes/{path}](operations/set_file_attribute.md)|PUT|Set file attribute|
|[/files/{path}](operations/list_files.md)|GET|List files and folders|
|[/index](operations/add_space_index.md)|POST|Create index for space|
|[/index](operations/get_space_indexes.md)|GET|Get index list for space|
|[/index/{iid}](operations/get_space_index.md)|GET|Get index|
|[/index/{iid}](operations/update_space_index.md)|PUT|Update index|
|[/metadata-id/{id}](operations/get_file_metadata_by_id.md)|GET|Get metadata|
|[/metadata-id/{id}](operations/set_file_metadata_by_id.md)|PUT|Set metadata|
|[/metadata/{path}](operations/get_file_metadata.md)|GET|Get metadata|
|[/metadata/{path}](operations/set_file_metadata.md)|PUT|Set metadata|
|[/query-index/{iid}](operations/query_space_indexes.md)|GET|Query index|
|[/spaces](operations/get_all_spaces.md)|GET|Get all spaces|
|[/spaces/{sid}](operations/get_space.md)|GET|Get basic space information|


<a name="monitoring_resource"></a>
### Monitoring
Metrics and change events monitoring related operations


|Path|Method|Description|
|---|---|---|
|[/changes/metadata/{sid}](operations/get_space_changes.md)|GET|Subscribe to file events|
|[/metrics/space/{sid}](operations/get_space_metrics.md)|GET|Get space metrics|
|[/metrics/space/{sid}/user/{uid}](operations/get_space_user_metrics.md)|GET|Get space user metrics|


<a name="replication_resource"></a>
### Replication
Replication, file distribution and transfer control operations


|Path|Method|Description|
|---|---|---|
|[/replicas-id/{fid}](operations/replicate_file_by_id.md)|POST|Replicate file or folder by ID|
|[/replicas-id/{fid}](operations/get_file_replicas_by_id.md)|GET|Get replicas by ID|
|[/replicas/{path}](operations/replicate_file.md)|POST|Replicate file or folder by path|
|[/replicas/{path}](operations/get_file_replicas.md)|GET|Get replicas by path|
|[/transfers](operations/get_all_transfers.md)|GET|Get all transfers|
|[/transfers/{tid}](operations/get_transfer_status.md)|GET|Get transfer status|
|[/transfers/{tid}](operations/cancel_transfer.md)|DELETE|Cancel specific transfer|



