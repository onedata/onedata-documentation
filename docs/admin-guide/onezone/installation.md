# Installation

This chapter describes the available **Onezone** installation methods.
Onezone communicates with external services or clients
using ports 53, 80, 443 and 9443. All of these ports need to be publicly
open except 9443 which is used for direct emergency access to the Onezone.

**Onezone** service can be deployed on multiple nodes for
high-availability purpose. If not mentioned otherwise it is assumed that
**Onezone** will be installed on a single node.

## Docker-based

Docker-based installation methods use our  [official Docker images][1]
to run **Onezone** on any [Linux OS supporting Docker][2].

The node on which **Onezone** will be deployed should fullfill the requirements shown in the table below.

| Requirement         | Minimum               | Optimal               |
| ------------------- | --------------------- | --------------------- |
| CPU                 | 4 vCPU                | 16 vCPU               |
| RAM                 | 12B                   | 32GB                  |
| Local disk          | SSD                   | SSD                   |
| Local storage space | 20GB                  | 40GB                  |
| OS                  | Any Docker compatible | Any Docker compatible |

### Manual installation using batch mode

#### Prerequisites

In order to ensure optimum performance of the **Onezone** service,
several low-level settings need to be tuned on the host machine. This applies
to both Docker based and package based installations, in particular to
nodes where Couchbase database instance are deployed.

After these settings are modified, the machine needs to be rebooted.

##### Increase maximum number of opened files

In order to install **Onezone** service on one of the supported operating systems, first make sure that the maximum limit of opened files is sufficient (preferably 63536, but below `/proc/sys/fs/file-max`). The limit can be checked using:

```sh
ulimit -n
1024
```

If necessary, increase the limit using:

```sh
$ sudo sh -c 'echo "* soft nofile 63536" >> /etc/security/limits.conf'
$ sudo sh -c 'echo "* hard nofile 63536" >> /etc/security/limits.conf'
```

> It might be also necessary to setup the limit in /etc/systemd/system.conf:
>
> ```sh
> sudo sh -c 'echo DefaultLimitNOFILE=65536 >> /etc/systemd/system.conf'
> sudo systemctl daemon-reexec
> ```

##### Swap preference settings

Make sure that the swap preference (i.e. *swappiness*) is set to `0` (or at most `1` - see \[here]\[3] for details):

```sh
$ cat /proc/sys/vm/swappiness
60
```

and if necessary decrease it using:

```sh
$ sudo sh -c 'echo "vm.swappiness=0" >> /etc/sysctl.d/50-swappiness.conf'
```

##### Disable Transparent Huge Pages feature

By default, many Linux machines have the Transparent Huge Pages feature enabled, which somewhat improves performance of machines running multiple application at once (e.g. desktop operating systems), however it deteriorates the performance of most database-heavy applications, such as **Onezone**.

These settings can be checked using the following commands (the output shown below presents the expected settings):

```
$ cat /sys/kernel/mm/transparent_hugepage/enabled
always madvise [never]

$ cat /sys/kernel/mm/transparent_hugepage/defrag
always madvise [never]
```

If any of the settings is different from the above, they should be changed permanently, which can be achieved for instance by creating a simple **systemd** unit file `/etc/systemd/system/disable-thp.service`:

```
[Unit]
Description=Disable Transparent Huge Pages

[Service]
Type=oneshot
ExecStart=/bin/sh -c "/bin/echo 'never' | /usr/bin/tee /sys/kernel/mm/transparent_hugepage/enabled"
ExecStart=/bin/sh -c "/bin/echo 'never' | /usr/bin/tee /sys/kernel/mm/transparent_hugepage/defrag"

[Install]
WantedBy=multi-user.target
```

and enabling it on system startup using:

```
$ sudo systemctl enable disable-thp.service
$ sudo systemctl start disable-thp.service
```

##### Node hostname

Make sure that the machine has a resolvable, domain-style hostname (it can be Fully Qualified Domain Name or just a proper entry in `/etc/hostname` and `/etc/hosts`) — for this tutorial it is set to `onezone-example.com`.

Following command examples assumes an environment variable `ONEZONE_HOST` is available, for instance:

```sh
$ export ONEZONE_HOST="onezone-example.com"
```

<!-- @TODO: Check if python is still a neccesity -->

##### Python

Make sure that python 2.x is installed on the machine. For example:

```sh
$ python -V
Python 2.7.12
```

##### Docker

The Docker software need to be installed on the machine. It can be done by using the convenience script from get.docker.com:

```sh
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh
$ sudo usermod -aG docker <your-user>
```

<!-- @TODO VFS-11766 missing chapter -->

<!-- as needed: link to configuration, compatibility-reference [versions]) -->

## 🚧 Under construction! 🚧

This section is coming soon. For now:

* see the [GitHub repository][] with docker-compose examples for Onezone deployment,
* see the counterpart in the [legacy docs][].

***

**Use the panel on the left to navigate to other sections.**

<!-- references -->

[GitHub repository]: https://github.com/onedata/onedata-deployments/tree/master/onezone/examples

[legacy docs]: https://onedata.org/#/home/documentation/20.02/doc/administering_onedata/onezone_tutorial[installation].html

[1]: https://hub.docker.com/r/onedata/onezone/

[2]: https://docs.docker.com/engine/installation/#supported-platforms
