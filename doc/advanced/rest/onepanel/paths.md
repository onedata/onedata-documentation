
<a name="paths"></a>
## Paths

<a name="onepanel_resource"></a>
### Onepanel
Common Onepanel resources and operations


|Path|Method|Description|
|---|---|---|
|[/cookie](operations/get_cookie.md)|GET|Get cluster cookie|
|[/hosts](operations/post_hosts.md)|POST|Create or join cluster|
|[/hosts](operations/get_hosts.md)|GET|Get cluster/discovered hosts|
|[/hosts/{host}](operations/delete_hosts_host.md)|DELETE|Remove cluster node|
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
|[/provider](operations/put_provider.md)|POST|Register provider|
|[/provider](operations/get_provider.md)|GET|Get provider details|
|[/provider](operations/delete_provider.md)|DELETE|Unregister provider|
|[/provider](operations/patch_provider.md)|PATCH|Modify provider details|
|[/provider/configuration](operations/put_provider_configuration.md)|POST|Configure provider deployment|
|[/provider/configuration](operations/get_provider_configuration.md)|GET|Get provider cluster configuration|
|[/provider/databases](operations/put_provider_databases.md)|POST|Deploy provider databases|
|[/provider/databases](operations/get_provider_databases.md)|GET|Get provider databases status|
|[/provider/databases](operations/patch_provider_databases.md)|PATCH|Start/stop provider databases|
|[/provider/databases/{host}](operations/get_provider_databases_host.md)|GET|Get provider database status|
|[/provider/databases/{host}](operations/patch_provider_databases_host.md)|PATCH|Start/stop provider database|
|[/provider/managers](operations/put_provider_managers.md)|POST|Deploy provider cluster managers|
|[/provider/managers](operations/get_provider_managers.md)|GET|Get provider cluster managers status|
|[/provider/managers](operations/patch_provider_managers.md)|PATCH|Start/stop provider cluster managers|
|[/provider/managers/{host}](operations/get_provider_managers_host.md)|GET|Get provider cluster manager status|
|[/provider/managers/{host}](operations/patch_provider_managers_host.md)|PATCH|Start/stop provider cluster manager|
|[/provider/spaces](operations/put_provider_spaces.md)|POST|Create or support space|
|[/provider/spaces](operations/get_provider_spaces.md)|GET|Get provider spaces|
|[/provider/spaces/{id}](operations/get_provider_spaces_id.md)|GET|Get space details|
|[/provider/spaces/{id}](operations/delete_provider_spaces_id.md)|DELETE|Revoke space support|
|[/provider/storages](operations/put_provider_storages.md)|POST|Configure storage|
|[/provider/storages](operations/get_provider_storages.md)|GET|Get storages|
|[/provider/storages/{name}](operations/get_provider_storages_name.md)|GET|Get storage details|
|[/provider/workers](operations/put_provider_workers.md)|POST|Deploy provider cluster workers|
|[/provider/workers](operations/get_provider_workers.md)|GET|Get provider cluster workers status|
|[/provider/workers](operations/patch_provider_workers.md)|PATCH|Start/stop provider cluster workers|
|[/provider/workers/{host}](operations/get_provider_workers_host.md)|GET|Get provider cluster worker status|
|[/provider/workers/{host}](operations/patch_provider_workers_host.md)|PATCH|Start/stop provider cluster worker|


<a name="onezone_resource"></a>
### Onezone
Resources and operations for managing Onezone deployment


|Path|Method|Description|
|---|---|---|
|[/zone/configuration](operations/put_zone_configuration.md)|POST|Configure zone deployment|
|[/zone/configuration](operations/get_zone_configuration.md)|GET|Get zone cluster configuration|
|[/zone/databases](operations/put_zone_databases.md)|POST|Deploy zone databases|
|[/zone/databases](operations/get_zone_databases.md)|GET|Get zone databases status|
|[/zone/databases](operations/patch_zone_databases.md)|PATCH|Start/stop zone databases|
|[/zone/databases/{host}](operations/get_zone_databases_host.md)|GET|Get zone database status|
|[/zone/databases/{host}](operations/patch_zone_databases_host.md)|PATCH|Start/stop zone database|
|[/zone/managers](operations/put_zone_managers.md)|POST|Deploy zone cluster managers|
|[/zone/managers](operations/get_zone_managers.md)|GET|Get zone cluster managers status|
|[/zone/managers](operations/patch_zone_managers.md)|PATCH|Start/stop zone cluster managers|
|[/zone/managers/{host}](operations/get_zone_managers_host.md)|GET|Get zone cluster manager status|
|[/zone/managers/{host}](operations/patch_zone_managers_host.md)|PATCH|Start/stop zone cluster manager|
|[/zone/workers](operations/put_zone_workers.md)|POST|Deploy zone cluster workers|
|[/zone/workers](operations/get_zone_workers.md)|GET|Get zone cluster workers status|
|[/zone/workers](operations/patch_zone_workers.md)|PATCH|Start/stop zone cluster workers|
|[/zone/workers/{host}](operations/get_zone_workers_host.md)|GET|Get zone cluster worker status|
|[/zone/workers/{host}](operations/patch_zone_workers_host.md)|PATCH|Start/stop zone cluster worker|



