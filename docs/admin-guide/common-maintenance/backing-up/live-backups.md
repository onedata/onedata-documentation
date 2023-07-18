### Live backups

The script
[odbackup.sh](https://github.com/onedata/onedata-deployments/blob/master/bin/odbackup.sh)
from
[onedata-deployments](https://github.com/onedata/onedata-deployments)
repository can be used to automate the backup process. It is
particularly useful for multinode onedata deployments — see the
`README.md` for usage details. In this procedure, the service nodes
are not stopped, but the snapshot is performed as much in parallel as
possible. Despite using LVM's atomic snapshots, this approach does not
guarantee complete integrity of the backups, as in rare cases the
backup may happen when application's state is not fully flushed from
memory to the disk. Nevertheless, the possible data loss caused by
live backups is marginal as service restoration / disaster recovery
typically uses a backup from several hours or days before an incident.
There is an ongoing effort to support live backups with guaranteed
data consistency.