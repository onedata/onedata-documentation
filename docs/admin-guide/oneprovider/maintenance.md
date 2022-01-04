# Maintenance

## Startup & shutdown 
<!-- TODO VFS-7218 restart too -->

## Backup & restore

All essential data for running the oneprovider service are placed in a single directory (for example /opt/onedata/oneprovider) during instalation. The directory contains configuration data for running the docker container as well as a persistence directory which contains the couchbase data and other essential folders which needs to be kept in case of re-creating or migrating the container.

The backup procedure is the following:

1. Stop the service. The service needs to be stopped as live backups are not currently supported.
```
sudo systemctl stop oneprovider
```
2. Backup the install directory in a tar file.
```
tar zcPf /opt/onedata/oneprovider /mybackups/oneprovider.tgz
```
3. Start the service.
```
sudo systemctl start oneprovider
```
4. Copy the tar file to a safe place, e.g.:
```
scp /mybackups/oneprovider.tgz some.remote.server:/backups/oneprovider.tgz
```

Note: In the case when the oneprovider service is deployed on multiple nodes repeat the procedure on each node.

The restore procedure is the following:

1. Copy the tar file of the last backup.
```
scp some.remote.server:/backups/oneprovider.tgz /mybackups/oneprovider.tgz
```
2. Restore the install directory from the tar file.
```
tar zxPf /mybackups/oneprovider.tgz
```
3. Start the service.
```
sudo systemctl start oneprovider
```

Note: If the service is started on another VM remember to assign to it the relevant public IP.


## Upgrading

## Troubleshooting
