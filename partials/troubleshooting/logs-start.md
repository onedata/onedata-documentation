## Logs

Logging plays a crucial role in troubleshooting and monitoring Onedata system.
It provides valuable insights into the system's operation, and potential issues,
and helps analyze and resolve problems efficiently.

**@insert onepanelOrServiceLogs**

### Log file location

1. Docker-based deployment (assuming the paths were set as in the tutorial)

```bash
# Onepanel logs
~$ ls /opt/onedata/**@insert serviceLower**/persistence/var/log/**@insert panelSnake**/
debug.log error.log info.log run_erl.log
```

```bash
# **@insert serviceUpper** logs
~$ ls /opt/onedata/**@insert serviceLower**/persistence/var/log/**@insert workerSnake**/
debug.log error.log info.log run_erl.log
```

2. Package based deployment

```bash
# Onepanel logs
~$ ls /var/log/**@insert panelSnake**/
debug.log error.log info.log run_erl.log
```

```bash
# **@insert serviceUpper** logs
~$ ls /var/log/**@insert workerSnake**/
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
   ~$ **@insert workerSnake** attach-direct
   ```

   You will be attached to the console and see the following prompt:

   ```bash
   Direct Shell: Use "Ctrl-D" to quit. "Ctrl-C" will terminate the **@insert workerSnake** node.
   Attaching to /tmp/**@insert workerSnake**/erlang.pipe.1 (^D to exit)

   (**@insert workerSnake**@node1.**@insert serviceLower**.local)1>
   ```

   Enter the command (the `.` at the end is required) and press `[Enter]`:

   ```bash
   (**@insert workerSnake**@node1.**@insert serviceLower**.local)1> logger:set_loglevel(debug).
   ok
   ```

   Detach from the console by pressing `[Ctrl + D]` — pressing `[Ctrl + C]` will
   kill the node!

   ```bash
   (**@insert workerSnake**@node1.**@insert serviceLower**.local)2> [Quit]
   ~$
   ```

   From now on, the debug logs will be written to the `debug.log` file as they
   appear. Remember to turn off the debug logs when you are finished:

   ```bash
   ~$ **@insert workerSnake** attach-direct

   (**@insert workerSnake**@node1.**@insert serviceLower**.local)3> logger:set_loglevel(info).
   ok

   ^D
   ```

   > **NOTE:** You can do the same for Onepanel, just replace `**@insert workerSnake**`
   > with `**@insert panelSnake**`.

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
   ~$ curl -k -sS -X GET https://**@insert serviceHostVar**/api/v3/**@insert serviceLower**/health | jq

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
