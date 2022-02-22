# Maintenance

## Startup & shutdown 
<!-- TODO VFS-7218 restart too -->

## Backup

All essential data for running the oneprovider service are placed in a
single directory (for example /opt/onedata/oneprovider) during
instalation. The directory contains configuration data for running the
docker container as well as a persistence directory which contains the
couchbase data and other essential folders which needs to be kept in
case of re-creating or migrating the container.

The backup procedure is the following:

1. Stop the service. The service needs to be stopped as live backups are 
not currently supported.
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

Note: In the case when the oneprovider service is deployed on multiple
nodes repeat the procedure on each node.  Note: If stopping of the
service is not desirable the script `odbackup.sh` can be used (see
next subsection).

### Live backups with odbackup.sh

The script
[odbackup.sh](https://github.com/onedata/onedata-deployments/blob/master/bin/odbackup.sh)
can be used to automate the backup process. The script is particularly
useful for multinode onedata deployments. The script is included in
the repo
[onedata-deployments](https://github.com/onedata/onedata-deployments).
See its `README.md` for usage details. Note that the script does not
stop the onedata services to allow live backups with eventual
consistency. The script writes the backups to an S3 bucket using
`s3cmd`, which needs to be configured before running the script.

Note: There is an ongoing effort for supporting live backups with guaranteed data consistency. 

## Restore and disaster recovery

### Virtual Machines preparing 

In case of disaster recovery the newly created VMs should be setup before restoring
from backup. The ansible playbook found in the repo 
[onedata-deployments](https://github.com/onedata/onedata-deployments) can be used to 
speed up the process. Alternatively, you can manually issue the commands included in
the section [Installation](instalation.md). 

Ideally, the new VMs should have the same IP addresses and hostname as
the destructed ones. If that is not possible additional steps will be
needed after the restoring to bring up the database (CouchBase). 

See the [README.md](https://github.com/onedata/onedata-deployments/tree/master/ansible) 
for details about configuring and running the ansible playbook. 

### Restoring from backup

After the setup is done the backup need to be restored. The restore procedure is the 
following:

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

### 
Note: If the service is started on another VM remember to assign to it
the relevant public IP.
Note: For multiple node deployments the above procedure should be done on each node.

## Upgrading

## Troubleshooting
