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

<!-- FIXME: napisać podobne podsumowanie jak jest w oneprovider troubleshooting -->
<!-- FIXME: napisać przykład innego statusu niż ok -->

<!-- FIXME: poniżej napisać więcej o tym co jest w logach panelu i providera -->

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

<!-- FIXME: przykład błędu i jego opis -->

<!-- @include troubleshooting/logs-severity-end.md -->

<!-- FIXME: napisać o specyficznych plikach logów dla oz_workera analogicznie do op_workera -->

<!-- FIXME: specyficzne dla onezone pliki logów? -->

<!-- @include troubleshooting/logs-erlang.md -->

<!-- references -->

<!-- @include troubleshooting/references.md -->
