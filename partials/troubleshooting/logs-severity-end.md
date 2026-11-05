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