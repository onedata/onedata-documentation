# Troubleshooting

## Connectivity issues

Oneprovider service requires several TCP ports (`80`, `443`, `6665`, `9443`) 
to be opened for proper operation. Some of these ports can be limited to 
internal network, in particular `9443` for Onepanel management interface. 

Furthermore, on all nodes of Oneprovider deployment where Couchbase instance 
is deployed, it exposes several additional ports. This means that the 
Couchbase security guidelines should be also followed.

For more information about ports setup see [Firewal setup](configuration/network-and-firewall.md)

## Logs

Logging plays a crucial role in troubleshooting and monitoring of the Onedata 
system. It provides valuable insights into the system's operation, potential 
issues, and helps analyze and resolve problems efficiently. 

In case of issues related to Oneprovider deployment, registering new storage 
backend or supporting spaces consult Onepanel logs. For any other kind of 
problem (data management, QoS, transfers, etc.) check Oneprovider logs.

### Log file Location

1. Docker based deployment (assuming the paths were set as in the tutorial)

```bash
# Onepanel logs
~$ ls /opt/onedata/oneprovider/persistence/var/log/op_panel/
debug.log error.log info.log run_erl.log
```

```bash
# Oneprovider logs
~$ ls /opt/onedata/oneprovider/persistence/var/log/op_worker/
debug.log error.log info.log run_erl.log
```

2. Package based deployment

```bash
# Onepanel logs
~$ ls /var/log/op_panel/
debug.log error.log info.log run_erl.log
```

```bash
# Oneprovider logs
~$ ls /var/log/op_worker/
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
    while the rotated file receives a suffix of ".0". For example, `error.log` 
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

1. Debug (level 7)

    The debug logs provides detailed information for debugging and analysis 
    purposes. It includes low-level system details and extensive diagnostic 
    data.

    By default, these logs are disabled, as they have a heavy impact on system 
    performance. However, there are cases when you might want to turn them on 
    for some time to identify problems. To do so, you need to attach to the 
    Erlang console of the node and execute `logger:set_loglevel(debug).`, 
    like this:

    ```bash
    ~$ op_worker attach-direct
    ```

    You will be attached to the console and see the following prompt:

    ```bash
    Direct Shell: Use "Ctrl-D" to quit. "Ctrl-C" will terminate the op_worker node.
    Attaching to /tmp/op_worker/erlang.pipe.1 (^D to exit)

    (op_worker@node1.oneprovider.local)1>
    ```

    Enter the command (the `.` at the end is required) and press [Enter]:

    ```bash
    (op_worker@node1.oneprovider.local)1> logger:set_loglevel(debug).
    ok
    ```

    Detach from the console by pressing `[Ctrl + D]` - pressing `[Ctrl + C]` will 
    kill the node!

    ```bash
    (op_worker@node1.oneprovider.local)2> [Quit]
    ~$
    ```

    From now on, the debug logs will be written to the `debug.log` file as they 
    appear. Remember to turn off the debug logs when you are finished:

    ```bash
    ~$ op_worker attach-direct

    (op_worker@node1.oneprovider.local)3> logger:set_loglevel(info).
    ok

    ^D
    ```

    > **NOTE:** You can do the same for Onepanel, just replace `op_worker` 
    > with `op_panel`.

2. Info (level 6)

    This severity is assigned for purely informational events providing 
    insights into normal system behavior and activities (e.g. application 
    start or stop).

3. Notice (level 5)

    This severity is assigned for normal but significant events like important 
    system operations and noteworthy activities (e.g. configuration changes).

4. Warning (level 4)

    The warning logs signals potential issues or abnormal system actions. 
    It indicates situations that might lead to problems in the future if action 
    in not taken now (e.g. network connectivity warnings or suspicious user 
    activities).

5. Error (level 3)

    The error logs indicates fails encountered during system operations 
    (e.g. authentication failures, or service unavailability).

# TODO describe 500 error_unexpected_error ?

6. Critical (level 2)

    This severity is assigned for severe errors that cause significant 
    disruptions to the system (e.g. critical hardware failures or 
    database corruption).

7. Alert (level 1)

    This severity is assigned for events requiring immediate administrator 
    response (e.g. database disk usage exceeding safe thresholds which can 
    cause loss of critical data).

8. Emergency (level 0)

    This is the highest possible severity assigned. It logs catastrophic events 
    resulting in complete system failure or shutdown (e.g. exhausted disk space).

The Onedata system organizes logs into separate files based on their severity 
levels. This approach simplifies log management and analysis. The commonly 
used log files include:

    `debug.log`: Contains logs from the debug level and higher.
    `info.log`: Contains logs from the info level and higher.
    ...
    `alert.log`: Contains logs from the alert level and higher.
    `emergency.log`: Contains logs from the emergency level.

### Other log files

There are specific log files related to specific components or mechanisms that 
provide detailed information primarily intended for system developers for 
debugging purposes.

1. `dbsync_changes`

    DBSync changes logs detail the remote provider sequence numbers applied by 
    this provider within the context of a space.

2. `dbsync_out_stream`

    DBSync out stream logs record the sequence numbers broadcasted by provider 
    within a particular space.

3. `file_access_audit.log` 

    File access audit logs record all file operations and provide a comprehensive 
    overview of file-related activities within the system. They are useful for 
    auditing and tracking file access activities.

    > **NOTE:** Due an overhead to every file operation, they cause a slight 
    > performance drop and as such are disabled by default. To enable them,
    > set `file_access_audit_log_enabled` to `true` in `op_worker` config.

4. `journal.log`

    This log file serves the purpose of quickly assessing the state of the 
    provider. It contains information about application starts, stops (whether 
    the stop was graceful) and also connection and disconnection information 
    with the zone. 

5. `link`

    RTransfer link logs consist of low-level, internal logs related to the 
    rtransfer mechanism. These logs require in-depth knowledge of our 
    software and are primarily utilized for debugging purposes.

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

### Erlang runtime system log files

Besides the log files generated by the Onedata system, there are also important 
log files generated by the Erlang ecosystem:

1. `crash.log`

    The `crush.log` file is generated by the crash dump handler in Erlang. 
    It captures crash-related information, including stack traces, error 
    messages, and other relevant details when an Erlang process or node 
    crashes. The `crush.log` file helps in identifying the cause of the 
    crash and provides insights for debugging and resolving issues.

    For more information about crush dumps, refer to [official documentation](https://www.erlang.org/doc/apps/erts/crash_dump.html).

2. `run_erl.log` and `erlang.log`

    These log files are generated by `run_erl` program. For more information 
    about them, refer to [official documentation](https://www.erlang.org/doc/man/run_erl.html).
