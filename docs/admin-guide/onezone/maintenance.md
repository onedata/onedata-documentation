---
serviceLower: 'onezone'
serviceUpper: 'Onezone'
---

# Maintenance

<!-- @include: docs/admin-guide/common-maintenance/startup-shutdown.md -->

<!-- @include: docs/admin-guide/common-maintenance/backing-up/intro.md -->

<!-- @include: docs/admin-guide/common-maintenance/backing-up/offline-backups.md -->

<!-- @include: docs/admin-guide/common-maintenance/backing-up/offline-backups-multinode-note.md -->

<!-- @include: docs/admin-guide/common-maintenance/backing-up/live-backups.md -->

<!-- @include: docs/admin-guide/common-maintenance/restoring/intro.md -->

### Restoring from backup

Run the following procedure on the VM designated to host the restored service:

1. Copy the tar file of the last backup.
```bash
scp some.remote.server:/backups/onezone.tgz /mybackups/onezone.tgz
```

2. Restore the installation directory from the tar file.
```bash
tar zxPf /mybackups/onezone.tgz
```

3. Start the service.
```bash
sudo systemctl start onezone
```

<!-- @include: docs/admin-guide/common-maintenance/restoring/notes.md -->

<!-- @include: docs/admin-guide/common-maintenance/todo-sections.md -->