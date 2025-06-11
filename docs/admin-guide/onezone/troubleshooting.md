# Troubleshooting

<!-- THIS FILE WAS GENERATED FROM TEMPLATE, DO NOT EDIT IT MANUALLY -->

## Connectivity issues

Oneprovider service requires several TCP ports (`80`, `443`, `6665`, `9443`)
to be opened for proper operation. Some of these ports can be limited to
an intranet, in particular `9443` for Onepanel management interface.

In a multi-node deployment scenario, you need to expose certain additional
ports on all nodes where the Couchbase instance is deployed:

* 8091 — Couchbase admin interface (Optional)
* 8092
* 11207
* 11209
* 11210
* 11211
* 18091-18092
* 21100-21299

::: danger SECURITY RISK
Exposing these ports to the public internet can pose a significant security risk.
Ensure that these ports are only accessible within the intranet to maintain
the integrity and security of your Couchbase deployment.
:::

For more information about ports setup, see [Firewall setup][].

## Health

To verify the status of the Oneprovider service, you have several options
available:

1. Using the `op_worker ping`/`op_panel ping` command:

   You can utilize the `op_worker/op_panel ping` command to check if the
   service is running. This command checks if the service node is active
   and prints “pong” when successful. If the node is stopped or unresponsive,
   it will display the message: “Node '$NAME\_HOST' not responding to pings.”

2. Using the `service` command:

   You can also use the service command to quickly check the status of the
   Oneprovider service. Execute the following commands to verify its status:

   ```bash
   ~$ service op_worker status

   pong
   op_worker is running
   ```

3. Nagios

   Monitoring the status of the Oneprovider service in the Onedata system can be
   achieved using Nagios, a popular monitoring tool. The monitoring information
   is accessible on a specific port and provides a basic overview of the status
   of all functional components of the Oneprovider service.

   To monitor the service status, you can utilize our [Nagios script][]
   or employ a simple script as shown below:

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
## Logs

Logging plays a crucial role in troubleshooting and monitoring Onedata system.
It provides valuable insights into the system's operation, and potential issues,
and helps analyze and resolve problems efficiently.

In case of issues related to Onezone deployment consult Onepanel logs. For any other kind of problem check Oneprovider logs.

### Log file location

1. Docker-based deployment (assuming the paths were set as in the tutorial)

```bash
# Onepanel logs
~$ ls /opt/onedata/onezone/persistence/var/log/oz_panel/
debug.log error.log info.log run_erl.log
```

```bash
# Onezone logs
~$ ls /opt/onedata/onezone/persistence/var/log/oz_worker/
debug.log error.log info.log run_erl.log
```

2. Package based deployment

```bash
# Onepanel logs
~$ ls /var/log/oz_panel/
debug.log error.log info.log run_erl.log
```

```bash
# Onezone logs
~$ ls /var/log/oz_worker/
debug.log error.log info.log run_erl.log
```

### Log file rotation

Log rotation ensures efficient management of log files. It prevents log files
from growing indefinitely and consuming excessive disk space. In the Onedata
system, log rotation is performed according to the following process:

1. Maximum Log Size:

   Each log file in the system has a configurable maximum size. The specific
   configuration for each log file may vary (e.g., for error.log, the default
   maximum size is set to 50 MB). When a log file reaches this defined maximum
   size, log rotation is triggered.

2. Numerical Suffix:

   When log rotation is initiated, the current log file is renamed by
   appending a numerical suffix. The original log file name remains unchanged,
   while the rotated file receives a suffix of “.0”. For example, `error.log`
   becomes `error.log.0`.

3. Incrementing Suffix:

   If a rotated log file with a specific suffix already exists, the suffix is
   incremented by 1. For instance, if `error.log.0` already exists, it is
   renamed to `error.log.1`. This process continues until the maximum number
   of rotated log files, denoted as *N*, is reached.

4. Removing Oldest Log Files:

   Once *N* reaches the configured maximum value for a specific log file
   (e.g., for `error.log`, the default maximum value is 9), the oldest rotated
   log is removed instead of being renamed to *MaxN + 1*.

New log entries are always written to the log file without any numerical suffix,
ensuring a continuous flow of logs in the latest file.

Specific configurations and values for log rotation may vary depending on the
log file. Administrators can customize these settings based on their
requirements and the available disk space to achieve optimal log management
in the Onedata system.

### Log severity levels (based on syslog levels)

There are eight logging levels, described below, that define the importance and
severity of an event.

1. Debug (level *7*, abbreviation *D*)

   The debug logs provide detailed information for debugging and analysis
   purposes. It includes low-level system details and extensive diagnostic
   data.

   By default, these logs are disabled, as they have a heavy impact on system
   performance. However, there are cases when you might want to turn them on
   for some time to identify problems. To do so, you need to attach to the
   Erlang console of the node and execute `logger:set_loglevel(debug).`,
   like this:

   ::: details Click me to view the steps

   ```bash
   ~$ oz_worker attach-direct
   ```

   You will be attached to the console and see the following prompt:

   ```bash
   Direct Shell: Use "Ctrl-D" to quit. "Ctrl-C" will terminate the oz_worker node.
   Attaching to /tmp/oz_worker/erlang.pipe.1 (^D to exit)

   (oz_worker@node1.onezone.local)1>
   ```

   Enter the command (the `.` at the end is required) and press `[Enter]`:

   ```bash
   (oz_worker@node1.onezone.local)1> logger:set_loglevel(debug).
   ok
   ```

   Detach from the console by pressing `[Ctrl + D]` — pressing `[Ctrl + C]` will
   kill the node!

   ```bash
   (oz_worker@node1.onezone.local)2> [Quit]
   ~$
   ```

   From now on, the debug logs will be written to the `debug.log` file as they
   appear. Remember to turn off the debug logs when you are finished:

   ```bash
   ~$ oz_worker attach-direct

   (oz_worker@node1.onezone.local)3> logger:set_loglevel(info).
   ok

   ^D
   ```

   > **NOTE:** You can do the same for Onepanel, just replace `oz_worker`
   > with `oz_panel`.

   :::

2. Info (level *6*, abbreviation *I*)

   This severity is assigned for purely informational events providing
   insights into normal system behavior and activities (e.g. application
   start or stop).

3. Notice (level *5*, abbreviation *N*)

   This severity is assigned for normal but significant events like important
   system operations and noteworthy activities (e.g. configuration changes).

4. Warning (level *4*, abbreviation *W*)

   The warning logs signal potential issues or abnormal system actions.
   It indicates situations that might lead to problems in the future if action
   is not taken now (e.g. network connectivity warnings or suspicious user
   activities).

5. Error (level *3*, abbreviation *E*)

   The error logs indicate fails encountered during system operations
   (e.g. authentication failures, or service unavailability).

   In case of an unforeseen or unexpected error in the Onedata system,
   the operation may result in an *internalServerError*. To provide more
   information about the error, a reference is included in the response:

   ```bash
   ~$ curl -k -sS -X GET https://$ONEZONE_HOST/api/v3/onezone/health | jq

   {
     "error": {
       "id": "internalServerError",
       "details": {
         "reference": "67f0194c57"
       },
       "description": "The server has encountered an error while processing this request. If the problem persists, please contact the site's administrators, citing the following reference: 67f0194c57."
     }
   }
   ```

   The included reference can be used to locate additional details, such as
   a stack trace, related to the error in the `error.log` file:
<!-- FIXME: przykład błędu i jego opis -->
6. Critical (level *2*, abbreviation *C*)

   This severity is assigned for severe errors that cause significant
   disruptions to the system (e.g. critical hardware failures or
   database corruption).

7. Alert (level *1*, abbreviation *A*)

   This severity is assigned for events requiring immediate administrator
   response (e.g. database disk usage exceeding safe thresholds which can
   cause loss of critical data).

8. Emergency (level *0*, abbreviation *M*)

   This is the highest possible severity assigned. It logs catastrophic events
   resulting in complete system failure or shutdown (e.g. exhausted disk space).

The Onedata system organizes logs into separate files based on their severity
levels. This approach simplifies log management and analysis. The commonly
used log files include:

```
debug.log: Contains logs from the debug level and higher.
info.log: Contains logs from the info level and higher.
...
alert.log: Contains logs from the alert level and higher.
emergency.log: Contains logs from the emergency level.
```

<!-- FIXME: napisać o specyficznych plikach logów dla oz_workera analogicznie do op_workera -->
<!-- FIXME: specyficzne dla onezone pliki logów? -->
### Erlang runtime system log files

Besides the log files generated by the Onedata system, there are also important
log files generated by the Erlang ecosystem:

1. `crash.log`

   The `crash.log` file is generated by the crash dump handler in Erlang.
   It captures crash-related information, including stack traces, error
   messages, and other relevant details when an Erlang process or node
   crashes. The `crash.log` file helps in identifying the cause of the
   crash and provides insights for debugging and resolving issues.

   For more information, refer to the [official documentation][crash_dump].

2. `run_erl.log` and `erlang.log`

   These log files are generated by `run_erl` program. For more information,
   refer to the [official documentation][run_erl].

<!-- references -->

[Firewall setup]: configuration/network-and-firewall.md

[Nagios script]: https://github.com/onedata/nagios-plugins-onedata

[crash_dump]: https://www.erlang.org/doc/apps/erts/crash_dump.html

[run_erl]: https://www.erlang.org/doc/man/run_erl.html
