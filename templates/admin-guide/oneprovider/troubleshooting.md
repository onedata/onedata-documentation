<!-- @include troubleshooting/start.md
  {
    "serviceUpper": "Oneprovider"
  }
-->

<!-- @include troubleshooting/health-start.md
  {
    "serviceUpper": "Oneprovider",
    "workerSnake": "op_worker"
  }
-->

   ```bash
   ~$ curl -sS https://$ONEPROVIDER_HOST/nagios | xmllint --format -

   <?xml version="1.0"?>
   <healthdata date="2023/06/08 10:52:52" status="ok">
     <op_worker name="op_worker@oneprovider-example.com" status="ok">
       <node_manager status="ok"/>
       <dispatcher status="ok"/>
       <atm_supervision_worker status="ok"/>
       <auto_storage_import_worker status="ok"/>
       <datastore_worker status="ok"/>
       <dbsync_worker status="ok"/>
       <dir_stats_service_worker status="ok"/>
       <fslogic_worker status="ok"/>
       <harvesting_worker status="ok"/>
       <middleware_worker status="ok"/>
       <provider_rpc_worker status="ok"/>
       <qos_worker status="ok"/>
       <rtransfer_worker status="ok"/>
       <session_manager_worker status="ok"/>
       <tp_router status="ok"/>
       <http_listener status="ok"/>
       <https_listener status="ok"/>
     </op_worker>
   </healthdata>
   ```


   In the provided XML response, each component of the Oneprovider service is
   listed with its respective status. The possible statuses include:

   * `ok` — indicates that the component is functioning correctly.

   * `out_of_sync` — indicates that the provider is lagging behind other
     providers and needs to catch up with changes.

   * `error` — indicates that there are issues with a particular component.

   By examining the status of each component and the overall `healthdata`
   status, you can determine whether the service is running properly.

   Here's an example illustrating a situation where the service is out of sync
   with errors in one of the components:

   ```bash
   ~$ curl -sS https://$ONEPROVIDER_HOST/nagios | xmllint --format -

   <?xml version="1.0"?>
   <healthdata date="2023/06/12 06:22:41" status="error">
     <op_worker name="op_worker@oneprovider-example.com" status="error">
       <node_manager status="ok"/>
       <dispatcher status="ok"/>
       <atm_supervision_worker status="ok"/>
       <auto_storage_import_worker status="ok"/>
       <datastore_worker status="error"/>
       <dbsync_worker status="out_of_sync"/>
       <dir_stats_service_worker status="ok"/>
       <fslogic_worker status="ok"/>
       <harvesting_worker status="ok"/>
       <middleware_worker status="ok"/>
       <provider_rpc_worker status="ok"/>
       <qos_worker status="ok"/>
       <rtransfer_worker status="ok"/>
       <session_manager_worker status="ok"/>
       <tp_router status="ok"/>
       <http_listener status="ok"/>
       <https_listener status="ok"/>
     </op_worker>
   </healthdata>
   ```

<!-- @include troubleshooting/logs-start.md
  {
    "onepanelOrServiceLogs": "In case of issues related to Oneprovider deployment, registering new storeage backend or supporting spaces consult Onepanel logs. For any other kind of problem (data management, QoS, transfers, etc.) check Oneprovider logs.",
    "serviceUpper": "Oneprovider",
    "serviceLower": "oneprovider",
    "workerSnake": "op_worker",
    "panelSnake": "op_panel",
    "serviceHostVar": "$ONEPROVIDER_HOST"
  }
-->

   ```erlang
   [E 2023-06-12 07:36:08.456 <0.24584.1>] An unexpected exception (ref: 67f0194c57) occurred in provider_middleware_plugin:get/2 line 221
   > Caught: error:badmatch
   > Stacktrace:
       cowboy_stream_h:execute/3 line 306
       cowboy_rest:upgrade/4 line 284
       cowboy_rest:set_resp_body/2 line 1472
       cowboy_rest:call/3 line 1583
       rest_handler:process_request/2 line 221
       middleware_rest_handler:handle_request/2 line 29
       middleware:handle/2 line 119
       provider_middleware_plugin:get/2 line 221
   ```

   This example shows an error entry containing the reference, the specific
   module (`provider_middleware_plugin`), and the line number (*line 221*)
   where the exception occurred. The stack trace provides additional
   information about the sequence of function calls leading to the error.
   Sharing this information with the developers will aid in diagnosing
   and fixing the functionality issue.

<!-- @include troubleshooting/logs-severity-end.md -->

### Other log files

There are specific log files related to specific components or mechanisms that
provide detailed information primarily intended for system developers for
debugging purposes.

1. `dbsync_changes`

   DBSync changes logs detail the remote provider sequence numbers applied by
   this provider within the context of a space.

2. `dbsync_out_stream`

   DBSync out stream logs record the sequence numbers broadcasted by the
   provider within a particular space.

3. `file_access_audit.log`

   File access audit logs record all file operations and provide a comprehensive
   overview of file-related activities within the system. They are useful for
   auditing and tracking file access activities.

   > **NOTE:** Due an overhead to every file operation, they cause a slight
   > performance drop and as such are disabled by default. To enable them,
   > set `file_access_audit_log_enabled` to `true` in `op_worker`
   > [config][].

4. `journal.log`

   This log file serves the purpose of quickly assessing the state of the
   provider. It contains information about application starts, stops (whether
   the stop was graceful) and also connection and disconnection information
   with the zone.

5. `link`

   RTransfer link logs consist of low-level, internal logs related to the
   rtransfer mechanism. These logs require in-depth knowledge of our
   software and are primarily utilized for debugging purposes.
<!-- FIXME: czy node_manager_monitoring istnieje? nie widzę go w środowisku -->
6. `node_manager_monitoring.log`

   This log file provides information about node activities, allowing
   visibility into node-level events, status changes, and system behavior.
   It is particularly useful for Onedata developers during the debugging
   process when troubleshooting issues.

7. `storage_import`

   Storage import logs provide a record of import actions, allowing us to track
   when and what was imported.

8. `throttling_monitoring.log`

   Throttling logs contain information about queue lengths (both internal and
   database) and the resulting throttling settings. They offer insights into
   the throttling mechanism and are useful for debugging purposes.


<!-- @include troubleshooting/logs-erlang.md -->

<!-- references -->

<!-- @include troubleshooting/references.md -->

[config]: configuration/advanced-config.md
