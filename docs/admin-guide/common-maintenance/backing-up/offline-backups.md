### Offline backups

Offline backups guarantee the complete integrity of the snapshot, but require 
a certain downtime of the service. If downtimes are acceptable, one can 
configure a periodic procedure that is run during low usage periods, e.g. at night.


1. Stop the service.
```bash
sudo systemctl stop {{$onedate.lower}}
```

2. Back up the installation directory to a tar file.
```bash
tar zcPf /opt/onedata/onezone /mybackups/onezone.tgz
```

3. Start the service.
```bash
sudo systemctl start onezone
```

4. Copy the snapshot to a safe place, preferably multiple locations that use 
different underlying storage infrastructures to achieve backup redundancy.
```bash
scp /mybackups/onezone.tgz some.remote.server:/backups/onezone.tgz
```

> **NOTE:** Tools such as rsync can be used to speed up the backups and limit
> the downtimes, by doing fast incremental copies, e.g.:
```bash
sudo systemctl stop onezone
rsync -a /opt/onedata/onezone /mybackups/onezone-backup
sudo systemctl start onezone
# compress and store the /mybackups/onezone-backup directory
# while the service is already back online
```