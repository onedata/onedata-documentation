# Installation

<!-- TODO: VFS-13158 onezone installation docs should be renewed and use templates -->

This chapter describes the available [Onezone][zones] installation methods.
Onezone communicates with external services or clients
using ports 53, 80, 443 and 9443. All of these ports need to be publicly
open except 9443 which is used for direct emergency access to the Onezone.

Onezone service can be deployed on multiple nodes for
high-availability purpose. If not mentioned otherwise, we assume that
Onezone will be installed on a single node.

::: tip NOTE
We do not officially support the traditional package installation method. If you desperately need to install it
from packages then inspect the relevant Dockerfile and adopt the installation steps to your case.
:::

## Docker-based

Docker-based installation methods use our [official Docker images][]
to run Onezone on any [Linux OS supporting Docker][].

The node on which Onezone will be deployed should fulfill the requirements shown in the table below.

| Requirement         | Minimum               | Optimal               |
| ------------------- | --------------------- | --------------------- |
| CPU                 | 4 vCPU                | 16 vCPU               |
| RAM                 | 12 GB                 | 32 GB                 |
| Local disk          | SSD                   | SSD                   |
| Local storage space | 20 GB                 | 40 GB                 |
| OS                  | Any Docker compatible | Any Docker compatible |

### Manual installation using batch mode

#### Prerequisites

In order to ensure optimum performance of the Onezone service,
several low-level settings need to be tuned on the host machine. This applies
to both Docker based and package based installations, in particular to
nodes where Couchbase database instance are deployed.

After these settings are modified, the machine needs to be rebooted.

##### Increase maximum number of opened files

In order to install Onezone service on one of the supported operating systems, first make sure that
the maximum limit of opened files is sufficient (preferably 63536, but below `/proc/sys/fs/file-max`).
The limit can be checked using:

```sh
ulimit -n
```

If necessary, increase the limit using:

```sh
sudo sh -c 'echo "* soft nofile 63536" >> /etc/security/limits.conf'
sudo sh -c 'echo "* hard nofile 63536" >> /etc/security/limits.conf'
```

::: tip
It might be also necessary to set up the limit in `/etc/systemd/system.conf`:

```sh
sudo sh -c 'echo DefaultLimitNOFILE=65536 >> /etc/systemd/system.conf'
sudo systemctl daemon-reexec
```

:::

##### Swap preference settings

Make sure that the swap preference (i.e. *swappiness*) is set to `0` (or at most `1` — see [here][install-swap-space]
for details):

```sh
cat /proc/sys/vm/swappiness
```

and if necessary, decrease it using:

```sh
sudo sh -c 'echo "vm.swappiness=0" >> /etc/sysctl.d/50-swappiness.conf'
sudo systemctl restart systemd-sysctl
```

##### Disable Transparent Huge Pages feature

By default, many Linux machines have the Transparent Huge Pages feature enabled, which somewhat improves
performance of machines running multiple application at once (e.g. desktop operating systems), however it
deteriorates the performance of most database-heavy applications, such as Onezone.

These settings can be checked using the following commands (the output shown below presents the expected settings):

```sh
cat /sys/kernel/mm/transparent_hugepage/enabled
# Expected output: always madvise [never]

cat /sys/kernel/mm/transparent_hugepage/defrag
# Expected output: always madvise [never]
```

If any of the settings is different from the above, they should be changed permanently, which can be achieved
for instance by creating a simple **systemd** unit file `/etc/systemd/system/disable-thp.service`:

```ini
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

```sh
sudo systemctl enable disable-thp.service
sudo systemctl start disable-thp.service
```

##### Node hostname

Make sure that the machine has a resolvable, domain-style hostname (it can be Fully Qualified Domain Name or
just a proper entry in `/etc/hostname` and `/etc/hosts`) — for this tutorial it is set to `onezone-example.com`.

Following command examples assumes an environment variable `ONEZONE_HOST` is available, for instance:

```sh
export ONEZONE_HOST="onezone-example.com"
```

##### Docker

The Docker software needs to be installed on the machine. It can be done by using the convenience
script from `get.docker.com`:

```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

<!-- @TODO VFS-11766 missing chapter -->

<!-- as needed: link to configuration, compatibility-reference [versions]) -->


<!-- references -->

[GitHub repository]: https://github.com/onedata/onedata-deployments/tree/master/onezone/examples

[legacy docs]: https://onedata.org/#/home/documentation/20.02/doc/administering_onedata/onezone_tutorial[installation].html

[official Docker images]: https://hub.docker.com/r/onedata/onezone/

[Linux OS supporting Docker]: https://docs.docker.com/engine/installation/#supported-platforms

[zones]: ../../intro.md#zones

[install-swap-space]: https://developer.couchbase.com/documentation/server/current/install/install-swap-space.html
