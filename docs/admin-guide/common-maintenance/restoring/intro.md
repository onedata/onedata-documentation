## Restoring

### Preparation of Virtual Machines 

Some disaster recovery scenarios require creation of new VMs to
restore the service.  The [ansible
playbook](https://github.com/onedata/onedata-deployments/tree/master/ansible)
from
[onedata-deployments](https://github.com/onedata/onedata-deployments)
repository can be used to speed up the process. Alternatively, one can
manually run the commands included in the
[Installation](/admin-guide/oneprovider/installation.md) section.

Ideally, the new VMs should have the same IP addresses and hostnames
as the original ones. If that is not possible, additional steps will
be needed after the restoring to bring up the Couchbase database that
depends on the IP addresses in its cluster configuration. In this
case, refer to the official documentation on how to set up a Couchbase
cluster.