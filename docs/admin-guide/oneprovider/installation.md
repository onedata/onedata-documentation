# Installation

<!-- @TODO VFS-11766 missing chapter -->

<!-- as needed: link to configuration, compatibility-reference [versions]). We need to decide/discuss. -->

<!-- @TODO VFS-13169 compatibility reference -->

This chapter describes the available [Oneprovider][providers] installation methods.
All supported installation methods use our [official Docker images][docker-images]
to run Oneprovider on any [Linux OS supporting Docker][supported-platforms].

Oneprovider service can be deployed on multiple nodes for
high-availability purpose. If not mentioned otherwise, we assume that
Oneprovider will be installed on a single node.

There are few installation methods shortly described further to help you choose which one is best for you:

* [Onedatify CLI wizard][] — this method uses our convenient script integrated with Onedata UI which
  guides you through the installation process.
  This is the recommended quickstart method.
* [Graphical wizard][] — the installation is done by first running an empty instance of Oneprovider
  which later is being configured by clicking through some forms. It offers better configurability than the Onedata CLI
  wizard, but still user-friendly.
* [Batch mode][] — useful for more skilled administrators wanting a specifically configured deployment.
  The deployment happens in batch mode, which does not require manual steps. It is useful for automated deployments.
  The installation is done by preparing an YAML configuration file for Oneprovider and then running the service.

::: tip NOTE
Regardless of the chosen method, the node should be initially prepared — see [prerequisites][].\
After the successful installation, you can further configure your Oneprovider — see the [Configuration][] topic in
the navigation panel on the left.
:::

::: tip NOTE
We do not officially support the traditional package installation method. If you desperately need to install it 
from packages then inspect the relevant Dockerfile and adopt the installation steps to your case.
:::

## Hardware requirements

The node on which Oneprovider will be deployed should fulfill the requirements shown in the table below.

| Requirement               | Minimum                          | Optimal                          |
| ------------------------- | -------------------------------- | -------------------------------- |
| CPU                       | 4 vCPU                           | 16 vCPU                          |
| RAM                       | 16 GB                            | 64 GB                            |
| Root disk                 | SSD (25 GB)                      | SSD (50 GB)                      |
| Disk for Onedata software | 20 GB + 8 MB for each 1000 files | 40 GB + 8 MB for each 1000 files |

## Prerequisites

### Access to Onezone

You should have at least user-level access to existing Onezone instance before deploying
Oneprovider. In a common scenario, the Onezone instance has already been set up by your organization,
and you get access to it according to the organization's access policy. If you don't have such a possibility you can use
our Onezone service available at [demo.onedata.org][demo] (see the [user quickstart][] section for details).
Another possibility is deploying your own Onezone (see the [Onezone installation][] chapter).

### Public IP and ports

The node should have a network interface with public IP. Oneprovider communicates with external services or clients
using ports 80, 443, 4443, 6665 and 9443. All of these ports need to be publicly open, except 9443, which is used for
direct emergency access to the Oneprovider.

::: warning
We strongly recommend closing all other ports from public access for security. Oneprovider
runs some internal services on the host, including the Couchbase DB, or the built-in 
Erlang daemon EPMD. Exposing those for external access may create attack vectors.
:::

### Internet domain

The node should be accessible via its FQDN. You can supply your own FQDN or use the
subdomain delegation feature of Onedata, which will generate FQDN within the domain
managed by the Onezone service.

### SSL certificate

Oneprovider can automatically provide a LE (Let's Encrypt) certificate for the node, which is the default action. You can also provide your own certificate manually.

### Preparing the node
FIXME for Darin: this is too vague for the reader. We need to break it down into two
scenarios where Oneprovider gets the domain from the admin (and the admin needs to set
up the DNS), or uses subdomain delegation and then you don't have to care about the
domain - it will happen automatically.

### TLS certificates

FIXME for Darin: two scenarios, either the admin organizes the web cert (this may be 
both for non-delegated subdomain and delegated subdomain) or uses LE (also for both 
cases, so they are orthogonal). In the latter, you don't have to care about the cert -
it will happen automatically and be refreshed automatically.

### VM setup

#### Using Ansible script

The **recommended way** is to use our battle-tested Ansible script to set up your VM.

Clone the repository on your VM:

```sh
git clone https://github.com/onedata/onedata-deployments.git
cd onedata-deployments
```

Then, follow the instructions that can be found:
* in the repository: `./initial-vm-config/ansible/README.md`,
* or online: https://github.com/onedata/onedata-deployments/blob/master/initial-vm-config/ansible/README.md 

#### Manual preparation

Alternatively, you may perform the steps 
[manually](https://github.com/onedata/onedata-deployments/blob/master/initial-vm-config/manual/README.md). 
Note that the Oneprovider service is quite sensitive to the network settings and depends
on nuances well-captured by the Ansible playbook. Use the manual approach only as the last 
resort.

FIXME Darin: move below manual instructions to the repo: 
https://github.com/onedata/onedata-deployments/blob/master/initial-vm-config/manual/README.md


In order to ensure optimum performance of the Oneprovider service,
several low-level settings need to be tuned on the host machine. This applies
to both Docker based and package based installations, in particular to
nodes where Couchbase database instance are deployed.

##### Increase maximum number of opened files

In order to install Oneprovider service on one of the supported operating systems, first make sure that the maximum
limit of opened files is sufficient (preferably 63536, but below `/proc/sys/fs/file-max`). The limit can be checked
using:

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
the performance of machines running multiple application at once (e.g. desktop operating systems), however it
deteriorates the performance of most database-heavy applications, such as Oneprovider.

These settings can be checked using the following commands (the output shown below presents the expected settings):

```sh
cat /sys/kernel/mm/transparent_hugepage/enabled
# Expected output: always madvise [never]
```

```sh
cat /sys/kernel/mm/transparent_hugepage/defrag
# Expected output: always madvise [never]
```

If any of the settings is different from the above, they should be changed permanently, which can be achieved for
instance by creating a simple **systemd** unit file `/etc/systemd/system/disable-thp.service`:

::: tip NOTE
If the output is `cat: /sys/kernel/mm/transparent_hugepage/enabled: No such file or directory` then
THP feature is not configured in the kernel and no further action is required.
:::

```systemd
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

Make sure that the machine has a resolvable, domain-style hostname (it can be Fully Qualified Domain Name or just
a proper entry in `/etc/hostname` and `/etc/hosts`) — for this tutorial it is set to `oneprovider-example.com`.

Following command examples assumes an environment variable `ONEPROVIDER_HOST` is available, for instance:

```sh
export ONEPROVIDER_HOST="oneprovider-example.com"
```

::: tip NOTE
You can check the proper setting of hostname with the hostname command, for example:
:::

```sh
hostname
# Example output: oneprovider-example
hostname -f
# Example output: oneprovider-example.com
```

##### Docker

The Docker software needs to be installed on the machine. It can be done by using the convenience
script from `get.docker.com`:

```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

##### Set kernel parameters

It is recommended to set some kernel parameters. The network memory limits influence the file transfer performance.

```sh
echo "net.core.wmem_max = 16777216" | sudo tee -a /etc/sysctl.conf
echo "net.core.rmem_max = 16777216" | sudo tee -a /etc/sysctl.conf
echo "kernel.unprivileged_userns_clone = 0" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

##### Prepare persistence volume

The following commands require an empty block device to be available. The existing data on
the block device will be lost. A logical volume will be created on this block device. It is intended to store
the persistent data of Onedata services. Using an LVM volume allows for better management of the deployment,
especially when doing snapshot-based live backups.

```sh
# Replace sdX with your actual block device
BLOCK_DEVICE=/dev/sdX
```

```sh
sudo mkdir -p /opt/onedata
sudo chmod 0755 /opt/onedata
sudo pvcreate ${BLOCK_DEVICE}
sudo vgcreate onedata_vg ${BLOCK_DEVICE}
sudo lvcreate -l 80%VG -n lvol0 onedata_vg
sudo mkfs.ext4 /dev/onedata_vg/lvol0
sudo mount /dev/onedata_vg/lvol0 /opt/onedata
echo '/dev/onedata_vg/lvol0 /opt/onedata ext4 defaults 0 0' | sudo tee -a /etc/fstab
```

After these settings are modified, the machine needs to be rebooted.


## Onedatify CLI wizard

Onedatify is an easy-to-use script for automating the deployment of Docker-based Oneprovider instance. The script
automatically registers the Oneprovider instance to a selected Onezone service and allows for interactive
configuration of a storage backend with eventual enabling import of legacy data sets.

### Prerequisites

In addition to the general prerequisites, this method also requires access to an existing user account in the Onezone
instance, with which Oneprovider should register.

### Deploying Oneprovider

Follow carefully the following steps.

#### Creating a new space in Onezone

::: tip NOTE
Skip this step if you want to support an existing space.
:::

The first step to deploy Oneprovider using Onedatify script is to create a new space, which will be automatically
supported by the new Oneprovider instance.

Open the Web GUI and in the **Data** tab, click on the **+** (plus sign in the circle) button.

![screen-onedatify-create-space][]

#### Generating one-line Onedatify command in Onezone

Navigate to the **Data > *Space name* > Providers** view. Click on the **Add support** button in the main view.

Select the tab **Deploy your own Oneprovider**:

![screen-onedatify-deploy-provider-command][]

and copy the generated command.

::: tip NOTE
If you would like to expose a directory containing an existing data set, then select the tab **Expose existing data
set** and copy the generated command.
:::

#### Run the command on the target host

Paste the copied command in the terminal on the Oneprovider machine (as superuser or as a user with sudo privileges).

Check the prerequisite list and confirm to proceed to the next step:

![screen-onedatify-step-1][]

If necessary, the Onedatify script will ask for permission to install all necessary dependencies including Docker and
Docker Compose.

After the installation of dependencies is complete, the script will ask several questions and suggest default
setting for each one:

![screen-onedatify-step-2][]

The progress can be monitored on a separate terminal using the following command:

```sh
journalctl -u onedatify.service -f
```

After the deployment is complete, the following message will be shown, with connection details for administration panel
for the Oneprovider instance:

![screen-onedatify-step-5][]

## Graphical wizard

The prerequisites for this installation method are the same as for the installation using
batch mode. With this method, the Onedata cluster is configured and deployed by using the
Onepanel Web GUI.

#### Customizing Oneprovider Docker Compose script

Similarly to the previous installation method we need to create some directories and prepare a `docker-compose.yml`
file. Create the following directories:

```sh
sudo mkdir -p /opt/onedata/oneprovider/persistence
sudo mkdir -p /opt/onedata/oneprovider/certs
```

Create the following Docker Compose file in `/opt/onedata/oneprovider/docker-compose.yml`:

```yaml
version: '2.0'
services:
  node1.oneprovider.localhost:
    # Oneprovider Docker image version
    image: onedata/oneprovider:xRELEASExVERSIONx
    # Hostname (in this case the hostname inside Docker network)
    hostname: node1.oneprovider.localhost
    # The IP of VM need to be placed below under extra_hosts, for example:
    # - "node1.oneprovider.localhost:10.20.30.5"
    extra_hosts:
      - "node1.oneprovider.localhost:place-the-VM-IP-here"
    # dns: 8.8.8.8 # Optional, in case Docker containers have no DNS access
    # Host network mode is preferred, but on some systems may not work (e.g. CentOS)
    # To use bridge network
    network_mode: host
    privileged: true
    # Friendly name of the Oneprovider Docker container
    container_name: oneprovider-1
    # Mapping of volumes to Oneprovider container
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
      # Oneprovider runtime files
      - "/opt/onedata/oneprovider/persistence:/volumes/persistence"
      # Additional, trusted CA certificates (all files from this directory will be added)
      #- "/opt/onedata/oneprovider/cacerts:/etc/op_worker/cacerts"
      # The whole host filesystem - for convenience
      - "/:/hostfs"
      # Uncoment lines below if you will not use the built-in Let's Encrypt client
      ## SSL certificate
      #- "/opt/onedata/oneprovider/certs/cert.pem:/etc/op_panel/certs/web_cert.pem"
      ## SSL certificate key
      #- "/opt/onedata/oneprovider/certs/key.pem:/etc/op_panel/certs/web_key.pem"
      ## Certificate chain for the TLS certificate above
      #- "/opt/onedata/oneprovider/certs/cacert.pem:/etc/op_panel/certs/web_chain.pem"
    # Expose the necessary ports from Oneprovider container to the host
    # This section can be commented when using host mode networking
    ports:
      - "80:80"
      - "443:443"
      - "4443:4443"
      - "6665:6665"
      - "9443:9443"
    environment:
      # Force Onepanel not to read configuration from environment variable
      ONEPANEL_BATCH_MODE: "false"
```

Prepare the systemd files for Oneprovider service as shown in the section
[Running Docker based installation using systemd][] and run it:

```sh
sudo systemctl enable oneprovider.service
sudo systemctl start oneprovider.service
```

#### Deploying the Onedata cluster using the Web GUI

Start a web browser and open [https://localhost:9443][1]. If the browser is not started on the provider
VM, replace localhost with the IP of the VM. You may need to accept the SSL security exception in your browser.
The deployment process is straightforward — just follow the instructions on the subsequent pages. You can hover
the question marks for additional explanations. The following screenshots illustrate the process.

Click on the **Create a new cluster** button.

![screen-installation-gui-new-onepanel][]

Enter the new passphrase and click on the **Submit** button.

![screen-installation-gui-passphrase][]

Click on the **Create Oneprovider cluster** button.

![screen-installation-gui-welcome][]

Choose the components to be installed on the given node. For a one-node deployment, as in this example, select all
components. Click on the green **Deploy** button.

![screen-installation-gui-cluster-deployment][]

Register your provider in a given Onezone. Click on the link **show me how** for instructions. Paste the obtained
token and click on the green **Proceed** button.

![screen-installation-gui-registration][]

Fill the required form fields and click on the **Register** button.

![screen-installation-gui-registration-2][]

Check the correctness of IP address and click on the **Setup IP address** button.

![screen-installation-gui-ip-address-setup][]

Check the DNS configuration and click on the **Proceed** button.

![screen-installation-gui-dns-setup][]

Click on the **Obtain certificate** button.

![screen-installation-gui-web-certificate][]

Choose the type of storage and give it a name and provide the necessary parameters. Click on the **Add** button.

![screen-installation-gui-storages][]

Finally, click on the **Finish** button.

![screen-installation-gui-storages-2][]

Now you can start managing your cluster, e.g., support a space as described in [Space support][].

![screen-installation-gui-cluster-configured-successfully][]

## Batch mode

#### Customizing Oneprovider Docker Compose script

Oneprovider installation using Docker is very straightforward. This type of deployment uses Docker Compose and
requires a `docker-compose.yml` file to be prepared.

In case of Docker based deployment all configuration information needed to install Oneprovider can be included directly
in the Docker Compose script. This tutorial assumes that all Oneprovider configuration and log files will be stored
in the folder `/opt/onedata/oneprovider` on the host machine, but you can use any directory to which Docker has access
to. Make sure the partition where the `/opt` directory is mounted has at least 20 GB of free space for logs and database
files. For large systems with large numbers of files (>1M files) the space should be much bigger. Also consider setting
up the `persistence` folder on a separate partition with backup.

Create the following directories:

```sh
sudo mkdir -p /opt/onedata/oneprovider/persistence
sudo mkdir -p /opt/onedata/oneprovider/certs
sudo mkdir -p /mnt/data
```

::: tip NOTE
This example will set up the first POSIX storage backend in `/mnt/data`. 
Possibly, it could be a mount point of a block volume on the host.
:::

Create the following Docker Compose file in `/opt/onedata/oneprovider/docker-compose.yml`:

```yaml
version: '2.0'
services:
  node1.oneprovider.localhost:
    # Oneprovider Docker image version
    image: onedata/oneprovider:xRELEASExVERSIONx
    # Hostname (in this case the hostname inside Docker network)
    hostname: node1.oneprovider.localhost
    # The IP of VM need to be placed below under extra_hosts, for example:
    # - "node1.oneprovider.localhost:10.20.30.5"
    extra_hosts:
      - "node1.oneprovider.localhost:place-the-VM-IP-here"
    # dns: 8.8.8.8 # Optional, in case Docker containers have no DNS access
    # Host network mode is preferred, but on some systems may not work (e.g. CentOS)
    network_mode: host
    # Friendly name of the Oneprovider Docker container
    container_name: oneprovider-1
    # Mapping of volumes to Oneprovider container
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
      # Oneprovider runtime files
      - "/opt/onedata/oneprovider/persistence:/volumes/persistence"
      # Overlay configs
      - "/opt/onedata/oneprovider/op-panel-overlay.config:/etc/op_panel/overlay.config"
      - "/opt/onedata/oneprovider/op-worker-overlay.config:/etc/op_worker/overlay.config"
      # Additional, trusted CA certificates (all files from this directory will be added)
      - "/opt/onedata/oneprovider/cacerts:/etc/op_worker/cacerts"
      # Uncoment lines below if you have disabled the built-in Let's Encrypt client
      ## SSL certificate
      #- "/opt/onedata/oneprovider/certs/cert.pem:/etc/op_panel/certs/web_cert.pem"
      ## SSL certificate key
      #- "/opt/onedata/oneprovider/certs/key.pem:/etc/op_panel/certs/web_key.pem"
      ## Certificate chain for the TLS certificate above
      #- "/opt/onedata/oneprovider/certs/cacert.pem:/etc/op_panel/certs/web_chain.pem"
      # a block data volume (POSIX) for supporting a space - if applicable
      - "/mnt/data:/volumes/storage"

    # Expose the necessary ports from Oneprovider container to the host
    # This section can be commented when using host mode networking
    ports:
      - "80:80"
      - "443:443"
      - "4443:4443"
      - "6665:6665"
      - "9443:9443"
    environment:
      # Force Onepanel to read configuration from environment variable
      ONEPANEL_BATCH_MODE: "true"
      # Provide initial Oneprovider configuration for Onepanel in environment variable
    # Emergency onepanel password
      ONEPANEL_EMERGENCY_PASSPHRASE: "Your_admin_password"
      ONEPROVIDER_CONFIG: |
        # Cluster configuration allows to specify distribution of Oneprovider
        # components over multiple nodes - here we deploy entire service on
        # a single node
        cluster:
          # Domain name of the provider within Docker network, will be appended
          # to all nodes specified below
          domainName: "oneprovider.localhost"
          autoDeploy: true
          nodes:
            n1:
              hostname: "node1"
          managers:
            mainNode: "n1"
            nodes:
              - "n1"
          workers:
            nodes:
              - "n1"
          databases:
            # Per node Couchbase cache size in MB for all buckets
            serverQuota: 4096
            # Per bucket Couchbase cache size in MB across the cluster
            bucketQuota: 4096
            nodes:
              - "n1"
          storages:
            # Add initial storage resource (optional - can be added later)
            # This example uses the /mnt/data directory on the host, which is
            # mounted to /volumes/storage directory inside Docker container
            local-posix:
              type: "posix"
              mountPoint: "/volumes/storage"
        oneprovider:
          geoLatitude: 50.0646501
          geoLongitude: 19.9449799
          register: true
          name: "ONEPROVIDER-DEMO"
          adminEmail: "admin@yourdomain.com"
          # Use built-in Let's Encrypt client to obtain and renew certificates
          letsEncryptEnabled: true

          # Automatically register this Oneprovider in Onezone with subdomain delegation
          subdomainDelegation: true
          subdomain: my-provider # Domain will be "my-provider.onedata.example.com"
          # Alternatively:
          # Automatically register this Oneprovider in Onezone without subdomain delegation
          # subdomainDelegation: false
          # domain: "oneprovider.yourdomain.com"

        onezone:
          # Address of the Onezone at which this Oneprovider will register
          domainName: "onedata.example.com"
```

Modify it according to your needs. You should at least change `onezone.domainName` (not `cluster.domainName`),
`geoLatitude`, `geoLongitude`, emergency password, `oneprovider.name`, `oneprovider.subdomain`. It assumed in
the above example that some POSIX type storage is available under the directory `/mnt/data`.
To install the necessary Docker images on the machine run:

```sh
docker compose -f /opt/onedata/oneprovider/docker-compose.yml pull
```

#### Setting up certificates

Since release 18.02.0-beta5, Oneprovider supports automatic certificate
management backed by Let's Encrypt. To use this option, it is only necessary
to enable this feature in Oneprovider Docker Compose configuration file
([see above][docker-compose]) or via GUI.

If you prefer to obtain and install certificates for Oneprovider service
manually, modify the Docker Compose file to mount PEM files inside the
container using paths listed in the section [Web certificate][].

#### Security and recommended firewall settings

Oneprovider service requires several TCP ports (`80`,`443`, `4443`, `6665`,`9443`) to be opened for proper operation.
Some of these ports can be limited to internal network, in particular `9443` for **Onepanel** management interface.

Furthermore, on all nodes of Oneprovider deployment where Couchbase
instance is deployed, it exposes several additional ports. This means that
the Couchbase [security guidelines][security-intro]
should be also followed.

For more information about ports setup, consult the section [Network and firewall][].

#### Running Docker based installation using systemd

Docker based installation can be conveniently managed using a **systemd** service unit. Simply create a
`/etc/systemd/system/oneprovider.service`:

```systemd
[Unit]
Description=Oneprovider Service
After=docker.service
Requires=docker.service

[Service]
ExecStartPre=/usr/local/bin/docker compose -f /opt/onedata/oneprovider/docker-compose.yml down
ExecStart=/usr/local/bin/docker compose -f /opt/onedata/oneprovider/docker-compose.yml up --abort-on-container-exit --no-recreate
ExecStop=-/usr/local/bin/docker compose -f /opt/onedata/oneprovider/docker-compose.yml down
Restart=always

[Install]
WantedBy=multi-user.target
```

Then the Oneprovider service can be managed using standard `systemctl` command:

```sh
# Enable Oneprovider service on machine startup
sudo systemctl enable oneprovider.service

# Start Oneprovider service
sudo systemctl start oneprovider.service
```

```sh
# Check status - Oneprovider usually gets up in few minutes max
sudo systemctl status oneprovider.service
# Expected output: ...
# May 25 23:25:32 localhost docker-compose[13499]: oneprovider-1                  | Congratulations! oneprovider has been successfully started.
```

```sh
# Stopping Oneprovider service
sudo systemctl stop oneprovider.service
```

```sh
# Restarting Oneprovider service while keeping all persistent files
sudo systemctl restart oneprovider.service
```

In case you need to start a fresh instance of Oneprovider, use the following commands. Note
that this will **remove all users' data** managed by this Oneprovider instance:

```sh
sudo systemctl stop oneprovider.service
sudo rm -rf /opt/onedata/oneprovider/persistence/*
sudo systemctl start oneprovider.service
```

<!-- # Deploy Oneprovider and attach empty storage with Onedatify -->

<!-- toc -->

<!-- ## Ansible/TF -->

<!-- TODO VFS-11766 missing section -->

<!-- ## k8s/helm -->

<!-- TODO VFS-11766 missing section -->

<!-- ## Native ->>
<!-- TODO VFS-11766 say that its not recommended, give a link to the dockerfile as reference -->

<!-- references -->

[providers]: ../../intro.md#providers

[docker-images]: https://hub.docker.com/r/onedata/oneprovider/tags

[supported-platforms]: https://docs.docker.com/engine/installation/#supported-platforms

[install-swap-space]: https://developer.couchbase.com/documentation/server/current/install/install-swap-space.html

[security-intro]: https://docs.couchbase.com/server/current/install/install-security-bp.html

[network and firewall]: ./configuration/network-and-firewall.md

[web certificate]: ./configuration/web-certificate.md

[space support]: ./configuration/space-support.md

[prerequisites]: #prerequisites

[configuration]: ./configuration/cluster-members.md

[docker-compose]: #customizing-oneprovider-docker-compose-script

[Onedatify CLI wizard]: #onedatify-cli-wizard

[Graphical wizard]: #graphical-wizard

[Batch mode]: #batch-mode

[Running Docker based installation using systemd]: #running-docker-based-installation-using-systemd

[demo]: https://demo.onedata.org

[user quickstart]: ../../user-guide/quickstart.md

[onezone installation]: ../onezone/installation.md

[screen-installation-gui-new-onepanel]: ../../../images/admin-guide/oneprovider/installation/installation-gui-new-onepanel.png

[screen-installation-gui-passphrase]: ../../../images/admin-guide/oneprovider/installation/installation-gui-passphrase.png

[screen-installation-gui-welcome]: ../../../images/admin-guide/oneprovider/installation/installation-gui-welcome.png

[screen-installation-gui-cluster-deployment]: ../../../images/admin-guide/oneprovider/installation/installation-gui-cluster-deployment.png

[screen-installation-gui-registration]: ../../../images/admin-guide/oneprovider/installation/installation-gui-registration.png

[screen-installation-gui-registration-2]: ../../../images/admin-guide/oneprovider/installation/installation-gui-registration-2.png

[screen-installation-gui-ip-address-setup]: ../../../images/admin-guide/oneprovider/installation/installation-gui-ip-address-setup.png

[screen-installation-gui-dns-setup]: ../../../images/admin-guide/oneprovider/installation/installation-gui-dns-setup.png

[screen-installation-gui-web-certificate]: ../../../images/admin-guide/oneprovider/installation/installation-gui-web-certificate.png

[screen-installation-gui-storages]: ../../../images/admin-guide/oneprovider/installation/installation-gui-storages.png

[screen-installation-gui-storages-2]: ../../../images/admin-guide/oneprovider/installation/installation-gui-storages-2.png

[screen-installation-gui-cluster-configured-successfully]: ../../../images/admin-guide/oneprovider/installation/installation-gui-cluster-configured-successfully.png

[screen-onedatify-create-space]: ../../../images/admin-guide/oneprovider/installation/onedatify-create-space.png

[screen-onedatify-deploy-provider-command]: ../../../images/admin-guide/oneprovider/installation/onedatify-deploy-provider-command.png

[screen-onedatify-step-1]: ../../../images/admin-guide/oneprovider/installation/onedatify-step-1.png

[screen-onedatify-step-2]: ../../../images/admin-guide/oneprovider/installation/onedatify-step-2.png

[screen-onedatify-step-5]: ../../../images/admin-guide/oneprovider/installation/onedatify-step-5.png

[1]: https://localhost:9443
