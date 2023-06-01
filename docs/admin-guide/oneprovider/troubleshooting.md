# Troubleshooting

## Logs

Consult Onepanel logs in case of issues related to Oneprovider deployment,
registering new storage backend or supporting spaces. For any other kind of 
problem (data management, QoS, transfers, etc.) check Oneprovider logs.

### Docker based deployment

In case of Docker based deployment, assuming the paths were set as in the tutorial, 
you can find logs below:


```bash
# Onepanel logs
~$ ls /opt/onedata/oneprovider/persistence/var/log/op_panel/
cmd.log debug.log error.log info.log run_erl.log
```

```bash
# Oneprovider logs
~$ ls /opt/onedata/oneprovider/persistence/var/log/op_worker/
debug.log error.log info.log run_erl.log
```

### Package based deployment

In case of package based deployment, you can find logs below:

```bash
# Onepanel logs
~$ ls /var/log/op_panel/
cmd.log debug.log error.log info.log run_erl.log
```

```bash
# Oneprovider logs
~$ ls /var/log/op_worker/
debug.log error.log info.log run_erl.log
```

### Severities

Each log is assigned a severity based on log event impact on users and urgency 
of action by the administrators.

#### Emergency

This is the highest possible severity assigned signifying that system is unusable.

#### Alert

This severity is assigned when immediate action is required (e.g. database 
disk usage exceeding safe thresholds which can cause loss of critical data).

#### Critical

This severity is assigned for critical errors (e.g. hardware failure).

#### Error

This severity is assigned when an application operation fails.

#### Warning

This severity is assigned for events signifying that operations may fail 
in the future if action is not taken now.

#### Notice

This severity is assigned for normal but significant events.

#### Info

This severity is assigned for purely informational events (e.g. apllication 
start or stop).

#### Debug

This severity is assigned for events useful only during the debug phase and 
may be of little value during production.

By default, these logs are disabled, as they have a heavy impact on system 
performance. However, there are cases when you might want to turn them on 
for some time to identify problems. To do so, you need to attach to the 
Erlang console of the node and execute `logger:set_loglevel(debug).`, like this:

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
