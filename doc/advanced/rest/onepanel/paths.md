
<a name="paths"></a>
## Paths

<a name="onepanel_resource"></a>
### Onepanel
Common Onepanel resources and operations


|Path|Method|Description|
|---|---|---|
|[/cookie](operations/get_cluster_cookie.md)|GET|Get cluster cookie|
|[/hosts](operations/create_cluster.md)|POST|Create or join cluster|
|[/hosts](operations/get_cluster_hosts.md)|GET|Get cluster or discovered hosts|
|[/hosts/{host}](operations/remove_cluster_host.md)|DELETE|Remove host from cluster|
|[/tasks/{id}](operations/get_task_status.md)|GET|Get background task result|
|[/users](operations/add_user.md)|POST|Create Onepanel user|
|[/users/{username}](operations/get_user.md)|GET|Get Onepanel user details|
|[/users/{username}](operations/remove_user.md)|DELETE|Remove Onepanel user|
|[/users/{username}](operations/modify_user.md)|PATCH|Modify Onepanel user details|


<a name="oneprovider_resource"></a>
### Oneprovider
Resources and operations for managing Oneprovider deployment


|Path|Method|Description|
|---|---|---|
|[/provider](operations/add_provider.md)|POST|Register provider|
|[/provider](operations/get_provider.md)|GET|Get provider details|
|[/provider](operations/remove_provider.md)|DELETE|Unregister provider|
|[/provider](operations/modify_provider.md)|PATCH|Modify provider details|
|[/provider/configuration](operations/configure_provider.md)|POST|Configure provider deployment|
|[/provider/configuration](operations/get_provider_configuration.md)|GET|Get provider cluster configuration|
|[/provider/databases](operations/add_provider_databases.md)|POST|Deploy provider databases|
|[/provider/databases](operations/get_provider_databases_status.md)|GET|Get provider databases status|
|[/provider/databases](operations/start_stop_provider_databases.md)|PATCH|Start/stop provider databases|
|[/provider/databases/{host}](operations/get_provider_database_status.md)|GET|Get provider database status|
|[/provider/databases/{host}](operations/start_stop_provider_database.md)|PATCH|Start/stop provider database|
|[/provider/managers](operations/add_provider_managers.md)|POST|Add provider cluster managers|
|[/provider/managers](operations/get_provider_managers_status.md)|GET|Get provider cluster managers status|
|[/provider/managers](operations/start_stop_provider_managers.md)|PATCH|Start/stop provider cluster managers|
|[/provider/managers/{host}](operations/get_provider_manager_status.md)|GET|Get provider cluster manager status|
|[/provider/managers/{host}](operations/start_stop_provider_manager.md)|PATCH|Start/stop provider cluster manager|
|[/provider/spaces](operations/support_space.md)|POST|Create or support space|
|[/provider/spaces](operations/get_provider_spaces.md)|GET|Get provider spaces|
|[/provider/spaces/{id}](operations/get_space_details.md)|GET|Get space details|
|[/provider/spaces/{id}](operations/revoke_space_support.md)|DELETE|Revoke space support for a space.|
|[/provider/storages](operations/add_storage.md)|POST|Add storage.|
|[/provider/storages](operations/get_storages.md)|GET|Get storages|
|[/provider/storages/{name}](operations/get_storage_details.md)|GET|Get storage details|
|[/provider/workers](operations/add_provider_workers.md)|POST|Add provider cluster workers|
|[/provider/workers](operations/get_provider_workers_status.md)|GET|Get provider cluster workers status|
|[/provider/workers](operations/start_stop_provider_workers.md)|PATCH|Start/stop provider cluster workers|
|[/provider/workers/{host}](operations/get_provider_worker_status.md)|GET|Get provider cluster worker status|
|[/provider/workers/{host}](operations/start_stop_provider_worker.md)|PATCH|Start/stop provider cluster worker|


<a name="onezone_resource"></a>
### Onezone
Resources and operations for managing Onezone deployment


|Path|Method|Description|
|---|---|---|
|[/zone/configuration](operations/configure_zone.md)|POST|Configure zone deployment|
|[/zone/configuration](operations/get_zone_configuration.md)|GET|Get zone cluster configuration|
|[/zone/databases](operations/add_zone_databases.md)|POST|Add zone databases|
|[/zone/databases](operations/get_zone_databases_status.md)|GET|Get zone databases status|
|[/zone/databases](operations/start_stop_zone_databases.md)|PATCH|Start/stop zone databases|
|[/zone/databases/{host}](operations/get_zone_database_status.md)|GET|Get zone database status|
|[/zone/databases/{host}](operations/start_stop_zone_databases_host.md)|PATCH|Start/stop zone database|
|[/zone/managers](operations/add_zone_managers.md)|POST|Add zone cluster managers|
|[/zone/managers](operations/get_zone_managers_status.md)|GET|Get zone cluster managers status|
|[/zone/managers](operations/start_stop_zone_managers.md)|PATCH|Start/stop zone cluster managers|
|[/zone/managers/{host}](operations/get_zone_manager_status.md)|GET|Get zone cluster manager status|
|[/zone/managers/{host}](operations/start_stop_zone_manager.md)|PATCH|Start/stop zone cluster manager|
|[/zone/workers](operations/add_zone_workers.md)|POST|Add zone cluster workers|
|[/zone/workers](operations/get_zone_workers_status.md)|GET|Get zone cluster workers status|
|[/zone/workers](operations/start_stop_zone_workers.md)|PATCH|Start/stop zone cluster workers|
|[/zone/workers/{host}](operations/get_zone_worker_status.md)|GET|Get zone cluster worker status|
|[/zone/workers/{host}](operations/start_stop_zone_worker.md)|PATCH|Start/stop zone cluster worker|



