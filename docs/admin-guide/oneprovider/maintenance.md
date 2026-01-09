# Maintenance

<!-- THIS FILE WAS GENERATED FROM TEMPLATE, DO NOT EDIT IT MANUALLY -->

## Startup & shutdown

<!-- TODO VFS-7218 restart too -->

<!-- TODO VFS-9376 find a way to reuse templates for repetitive chapters and use it here -->

## Backing up

If the standard installation procedure was followed, all data essential for
the Oneprovider service is placed in a single, self-contained directory
(`/opt/onedata/oneprovider`). This directory is sufficient to restore the
service or migrate it to another host. It contains the configuration for
running the docker container as well as the persistence directory which
contains database files and service configuration. **Backing up the service
boils down to creating snapshots of the installation directory.**

> **NOTE:** Apart from the Oneprovider service persistence that stores file
> metadata, administrators should back up the underlying storage systems
> that store the physical data exposed via logical Onedata spaces. This guide
> does not cover storage data backups, you should use backup procedures
> recommended for specific storage backend types.

Below are examples how [offline][1] and [live][2]
backups can be performed.

### Offline backups

Offline backups guarantee the complete integrity of the snapshot, but require
a certain downtime of the service. If downtimes are acceptable, one can
configure a periodic procedure that is run during low usage periods, e.g. at night.

1. Stop the service.

```bash
sudo systemctl stop oneprovider
```

2. Backup the installation directory to a tar file.

```bash
tar zcPf /opt/onedata/oneprovider /mybackups/oneprovider.tgz
```

3. Start the service.

```bash
sudo systemctl start oneprovider
```

4. Copy the snapshot to a safe place, preferably multiple locations that use
   different underlying storage infrastructures to achieve backup redundancy.

```bash
scp /mybackups/oneprovider.tgz some.remote.server:/backups/oneprovider.tgz
```

> **NOTE:** Tools such as rsync can be used to speed up the backups and limit
> the downtimes, by doing fast incremental copies, e.g.:

```bash
sudo systemctl stop oneprovider
rsync -a /opt/onedata/oneprovider /mybackups/oneprovider-backup
sudo systemctl start oneprovider
# compress and store the /mybackups/oneprovider-backup directory
# while the service is already back online
```

> **NOTE:** In multinode deployments, the procedure must be done on each host
> and synchronized, i.e. all nodes should be stopped, then backed up and started
> together.

### Live backups

The script
[odbackup.sh][3]
from
[onedata-deployments][4]
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

## Restoring

### Preparation of Virtual Machines

Some disaster recovery scenarios require creation of new VMs to
restore the service.  The [ansible
playbook][5]
from
[onedata-deployments][4]
repository can be used to speed up the process. Alternatively, one can
manually run the commands included in the
[Installation][] section.

Ideally, the new VMs should have the same IP addresses and hostnames
as the original ones. If that is not possible, additional steps will
be needed after the restoring to bring up the Couchbase database that
depends on the IP addresses in its cluster configuration. In this
case, refer to the official documentation on how to set up a Couchbase
cluster.

### Restoring from backup

Run the following procedure on the VM designated to host the restored service:

1. Copy the tar file of the last backup.

```bash
scp some.remote.server:/backups/oneprovider.tgz /mybackups/oneprovider.tgz
```

2. Restore the installation directory from the tar file.

```bash
tar zxPf /mybackups/oneprovider.tgz
```

3. Start the service.

```bash
sudo systemctl start oneprovider
```

> **NOTE:** If the service is started on another VM, it must be assigned the
> relevant public IP.

> **NOTE:** In multinode deployments, the procedure must be done on each host
> and the nodes should be started together.

## Upgrading

The Oneprovider service can be upgraded to a higher version, with some constraints described in the [Upgrades & compatibility][] chapter.

The software implements any required upgrade procedures, which are run when you start a new version on top of pre-existing persistence data originating from an older version. These procedures may take a long time, but are idempotent and resistant to the service restarts.

### Using the Onedatify

To upgrade the Oneprovider, which has been set up using the [Onedatify][]:

1. Log on into the Oneprovider host using SSH. 

2. Check the current version of the Oneprovider service, e.g. using the REST API:

```sh
curl https://127.0.0.1/api/v3/oneprovider/configuration | jq .version
```


3. Pull the docker image to make the upgrade smoother. In this example we want to upgrade our Oneprovider to version 21.02.9:

```sh
docker pull onedata/oneprovider:21.02.9
```

4. Run the upgrade command. The service will be stopped, backed up, and started on a newer docker image:

```sh
onedatify upgrade -v onedata/oneprovider:21.02.9
```

5. Inspect the created backup (optional):

```sh
ls /opt/onedata/oneprovider-backups
```

6. Check if the Oneprovider version changed to the target version.

```sh
curl https://127.0.0.1/api/v3/oneprovider/configuration | jq .version
```

### 🚧 Under construction! 🚧

The detailed description of the upgrading process is coming soon.

## Troubleshooting

<!-- references -->

[Installation]: installation.md

[1]: #offline-backups

[2]: #live-backups

[3]: https://github.com/onedata/onedata-deployments/blob/master/bin/odbackup.sh

[4]: https://github.com/onedata/onedata-deployments

[5]: https://github.com/onedata/onedata-deployments/tree/master/ansible

[Onedatify]: ./installation.md#onedatify-cli-wizard

[Upgrades & compatibility]: ../upgrades-and-compatibility.md