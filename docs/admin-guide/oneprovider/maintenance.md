---
serviceLower: 'oneprovider'
serviceUpper: 'Oneprovider'
---

# Maintenance

<!-- @include: docs/admin-guide/common-maintenance/startup-shutdown.md -->

<!-- @include: docs/admin-guide/common-maintenance/backing-up/intro.md -->

<!-- @include: docs/admin-guide/common-maintenance/backing-up/offline-backups.md -->

1. Stop the service.
```bash
sudo systemctl stop oneprovider
```

2. Back up the installation directory to a tar file.
```bash
tar zcPf /opt/onedata/onezone /mybackups/oneprovider.tgz
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
# compress and store the /mybackups/onezone-backup directory
# while the service is already back online
```

<!-- @include: docs/admin-guide/common-maintenance/backing-up/offline-backups-multinode-note.md -->

<!-- @include: docs/admin-guide/common-maintenance/backing-up/live-backups.md -->

<!-- @include: docs/admin-guide/common-maintenance/restoring/intro.md -->

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

<!-- @include: docs/admin-guide/common-maintenance/restoring/notes.md -->

<!-- @include: docs/admin-guide/common-maintenance/todo-sections.md -->