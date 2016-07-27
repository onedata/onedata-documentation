
<a name="paths"></a>
## Paths

<a name="onepanel_resource"></a>
### Onepanel
Common Onepanel resources and operations


|Path|Method|Description|
|---|---|---|
|[/hosts](operations/get_hosts.md)|GET|Get cluster/discovered hosts|
|[/hosts](operations/put_hosts.md)|PUT|Create or join cluster|
|[/hosts/{host}](operations/delete_host.md)|DELETE|Remove cluster node|
|[/tasks/{id}](operations/get_tasks_id.md)|GET|Get task result|
|[/users](operations/post_users.md)|POST|Create user|
|[/users/{username}](operations/get_users_username.md)|GET|Get user details|
|[/users/{username}](operations/delete_users_username.md)|DELETE|Remove user|
|[/users/{username}](operations/patch_users_username.md)|PATCH|Modify user details|


<a name="oneprovider_resource"></a>
### Oneprovider
Resources and operations for managing Oneprovider deployment


|Path|Method|Description|
|---|---|---|
|[/provider](operations/get_provider.md)|GET|Get provider details|
|[/provider](operations/put_provider.md)|PUT|Register provider|
|[/provider](operations/delete_provider.md)|DELETE|Unregister provider|
|[/provider](operations/patch_provider.md)|PATCH|Modify provider details|
|[/provider/configuration](operations/put_provider_configuration.md)|PUT|Create provider deployment|
|[/provider/databases](operations/get_provider_databases.md)|GET|Get provider databases status|
|[/provider/databases](operations/put_provider_databases.md)|PUT|Deploy provider databases|
|[/provider/databases](operations/patch_provider_databases.md)|PATCH|Start/stop provider databases|
|[/provider/databases/{host}](operations/get_provider_databases_host.md)|GET|Get provider database status|
|[/provider/databases/{host}](operations/patch_provider_databases_host.md)|PATCH|Start/stop provider database|
|[/provider/managers](operations/get_provider_managers.md)|GET|Get provider managers|
|[/provider/managers](operations/put_provider_managers.md)|PUT|Deploy provider managers|
|[/provider/managers](operations/patch_provider_managers.md)|PATCH|Start/stop provider managers|
|[/provider/managers/{host}](operations/get_provider_managers_host.md)|GET|Get provider manager status|
|[/provider/managers/{host}](operations/patch_provider_managers_host.md)|PATCH|Start/stop provider manager|
|[/provider/spaces](operations/get_provider_spaces.md)|GET|Get provider spaces|
|[/provider/spaces](operations/put_provider_spaces.md)|PUT|Create or support space|
|[/provider/spaces/{id}](operations/get_provider_spaces_id.md)|GET|Get space details|
|[/provider/spaces/{id}](operations/delete_provider_spaces_id.md)|DELETE|Revoke space support|
|[/provider/storages](operations/get_provider_storages.md)|GET|Get storages|
|[/provider/storages](operations/put_provider_storages.md)|PUT|Configure storage|
|[/provider/storages/{name}](operations/get_provider_storages_name.md)|GET|Get storage details|
|[/provider/workers](operations/get_provider_workers.md)|GET|Get provider workers|
|[/provider/workers](operations/put_provider_workers.md)|PUT|Deploy provider workers|
|[/provider/workers](operations/patch_provider_workers.md)|PATCH|Start/stop cluster worker service|
|[/provider/workers/{host}](operations/get_provider_workers_host.md)|GET|Get cluster worker status|
|[/provider/workers/{host}](operations/patch_provider_workers_host.md)|PATCH|Start/stop provider workers|


<a name="onezone_resource"></a>
### Onezone
Resources and operations for managing Onezone deployment


|Path|Method|Description|
|---|---|---|
|[/zone/configuration](operations/put_zone_configuration.md)|PUT|Create zone deployment|
|[/zone/databases](operations/get_zone_databases.md)|GET|Get zone databases status|
|[/zone/databases](operations/put_zone_databases.md)|PUT|Deploy zone databases|
|[/zone/databases](operations/patch_zone_databases.md)|PATCH|Start/stop zone databases|
|[/zone/databases/{host}](operations/get_zone_databases_host.md)|GET|Get zone database|
|[/zone/databases/{host}](operations/patch_zone_databases_host.md)|PATCH|Start/stop zone database|
|[/zone/managers](operations/get_zone_managers.md)|GET|Get zone managers status|
|[/zone/managers](operations/put_zone_managers.md)|PUT|Deploy zone managers|
|[/zone/managers](operations/patch_zone_managers.md)|PATCH|Start/stop zone managers|
|[/zone/managers/{host}](operations/get_zone_managers_host.md)|GET|Get zone manager status|
|[/zone/managers/{host}](operations/patch_zone_managers_host.md)|PATCH|Start/stop zone manager|
|[/zone/workers](operations/get_zone_workers.md)|GET|Get zone workers|
|[/zone/workers](operations/put_zone_workers.md)|PUT|Deploy zone workers|
|[/zone/workers](operations/patch_zone_workers.md)|PATCH|Start/stop zone workers|
|[/zone/workers/{host}](operations/get_zone_workers_host.md)|GET|Get zone worker status|
|[/zone/workers/{host}](operations/patch_zone_workers_host.md)|PATCH|Start/stop zone worker|



