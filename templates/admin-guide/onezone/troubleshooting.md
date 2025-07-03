<!-- @include troubleshooting/start.md
  {
    "serviceUpper": "Oneprovider",
    "ports": "TCP ports (`53`, `80`, `443`, `9443`) and the `53` UDP port"
  }
-->

<!-- @include troubleshooting/health-start.md
  {
    "serviceUpper": "Oneprovider",
    "workerSnake": "op_worker"
  }
-->

   ```bash
   ~$ curl -sS https://$ONEZONE_HOST/nagios | xmllint --format -

   <?xml version="1.0"?>
   <healthdata date="2025/06/09 11:56:40" status="ok">
     <oz_worker name="oz_worker@node1.onezone.local" status="ok">
       <node_manager status="ok"/>
       <dispatcher status="ok"/>
       <datastore_worker status="ok"/>
       <gs_worker status="ok"/>
       <tp_router status="ok"/>
       <https_listener status="ok"/>
     </oz_worker>
   </healthdata>
   ```

<!-- TODO: VFS-12930 Write summary similar as in oneprovider troubleshooting -->

<!-- TODO: VFS-12930 Write example of other status than "ok" -->

<!-- TODO: VFS-12930 Write below more about what is in onepanel and oneprovider logs -->

<!-- @include troubleshooting/logs-start.md
  {
    "onepanelOrServiceLogs": "In case of issues related to Onezone deployment consult Onepanel logs. For any other kind of problem check Oneprovider logs.",
    "serviceUpper": "Onezone",
    "serviceLower": "onezone",
    "workerSnake": "oz_worker",
    "panelSnake": "oz_panel",
    "serviceHostVar": "$ONEZONE_HOST"
  }
-->

<!-- TODO: VFS-12930 Example of error and its description -->

<!-- @include troubleshooting/logs-severity-end.md -->

<!-- TODO: VFS-12930 Write about specific log files for oz-worer analogous to op-worker -->

<!-- TODO: VFS-12930 Are there any specific onezone log files? -->

<!-- @include troubleshooting/logs-erlang.md -->

<!-- references -->

<!-- @include troubleshooting/references.md -->
