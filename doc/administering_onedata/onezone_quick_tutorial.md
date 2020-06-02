# Onezone quickstart tutorial

<!-- toc -->

 This tutorial assumes **Onezone** will be installed on a single node.

## Prerequisites
In order to ensure optimum performance of the **Onezone** service, several low-level settings need to be tuned on the host machine. This applies to both Docker based as well as package based installations, in particular to nodes where Couchbase database instance are deployed.

After these settings are modified, the machine needs to be rebooted.

### Increase maximum number of opened files
In order to install **Onezone** service on one of the supported operating systems, first make sure that the maximum limit of opened files is sufficient (preferably 63536, but below `/proc/sys/fs/file-max`). The limit can be checked using:

```sh
$ ulimit -n
1024
```

If necessary, increase the limit using:

```sh
$ sudo sh -c 'echo "* soft nofile 63536" >> /etc/security/limits.conf'
$ sudo sh -c 'echo "* hard nofile 63536" >> /etc/security/limits.conf'
```
> It might be also necessary to setup the limit in /etc/systemd/system.conf:
>```sh
$ sudo sh -c 'echo DefaultLimitNOFILE=65536 >> /etc/systemd/system.conf'
$ sudo systemctl daemon-reexec
```

### Swap preference settings
Make sure that the swap preference (i.e. *swappiness*) is set to `0` (or at most `1` - see [here](https://developer.couchbase.com/documentation/server/current/install/install-swap-space.html) for details):

```sh
$ cat /proc/sys/vm/swappiness
60
```
and if necessary decrease it using:
```sh
$ sudo sh -c 'echo "vm.swappiness=0" >> /etc/sysctl.d/50-swappiness.conf'
```

### Disable Transparent Huge Pages feature
By default, many Linux machines have the Transparent Huge Pages feature enabled, which improves apparent performance of machines running multiple applications at once, however it deteriorates the performance of most database-heavy applications, such as **Onezone**.

These settings can be checked using the following commands (here the output shown is the expected setting):

```
$ cat /sys/kernel/mm/transparent_hugepage/enabled
always madvise [never]

$ cat /sys/kernel/mm/transparent_hugepage/defrag
always madvise [never]
```

If any of the settings is different than the above, they should be changed permanently, which can be achieved for instance by creating a simple **systemd** unit file `/etc/systemd/system/disable-thp.service`:

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

and enabling it on start using:

```
$ sudo systemctl enable disable-thp.service
$ sudo systemctl start disable-thp.service
```

### Node hostname
Make sure that the machine has a resolvable, domain-style hostname (it can be Fully Qualified Domain Name or just a proper entry in `/etc/hostname` and `/etc/hosts`) - for this tutorial it is set to `onezone-example.com`.

Following command examples assumes an environment variable `ONEZONE_HOST` is available, for instance:

```sh
$ export ONEZONE_HOST="onezone-example.com"
```

### Python
Make sure that python 2.x is installed on the machine. For example:
```sh
$ python -V
Python 2.7.12
```

## Installing and Configuring onezone
Onezone installation using Docker is very straightforward. This type of deployment requires that docker and docker-compose have been installed on your server.

### Customizing Onezone Docker Compose script
In case of Docker based deployment all configuration information needed to install **Onezone** can be included directly in the Docker Compose script. This tutorial assumes that all **Onezone** configuration and log files will be stored in the directory `/opt/onedata/onezone` on the host machine, but you can use any directory to which Docker has access to. Make sure the partition where the `/opt` directory is mounted has at least 20GB of free space for logs and database files.

The following assumes you have prepared the following directory structure:

```sh
$ sudo mkdir -p /opt/onedata/onezone
$ sudo mkdir /opt/onedata/onezone/certs
$ sudo mkdir /opt/onedata/onezone/persistence
```

Create the following Docker Compose file in `/opt/onedata/onezone/docker-compose.yml`:

```Yaml
version: '2.0'
services:
  node1.onezone.localhost:
    # Onezone Docker image version
    image: onedata/onezone:__ONEDATA_RELEASE__
    # Hostname (in this case the hostname inside Docker network)
    hostname: node1.onezone.localhost
    # dns: 8.8.8.8 # Optional, in case Docker containers have no DNS access
    container_name: onezone-1
    # Mapping of volumes to Onezone container
    volumes:
       - "/var/run/docker.sock:/var/run/docker.sock"
       # Onezone runtime files
       - "/opt/onedata/onezone/persistence:/volumes/persistence"
       # OpenID configuration
       - "/opt/onedata/onezone/auth.config:/etc/oz_worker/auth.config"
       # Uncoment lines below if you disabled the built-in Let's Encrypt client
       ## SSL certificate
       #- "/ozt/onedata/onezone/certs/cert.pem:/etc/oz_panel/certs/web_cert.pem"
       ## SSL certificate key
       #- "/ozt/onedata/onezone/certs/key.pem:/etc/oz_panel/certs/web_key.pem"
       ## Certificate chain for the TLS certificate above
       #- "/ozt/onedata/onezone/certs/cacert.pem:/etc/oz_panel/certs/web_chain.pem"
    # Expose the necessary ports from Onezone container to the host
    ports:
      - "53:53"
      - "53:53/udp"
      - "443:443"
      - "80:80"
      - "9443:9443"
    environment:
      # Force Onepanel to read configuration from environment variable
      ONEPANEL_BATCH_MODE: "true"
      # Provide initial Onezone configuration for Onepanel in environment variable
      ONEZONE_CONFIG: |
        # Cluster configuration allows to specify distribution of Onezone
        # components over multiple nodes - here we deploy entire service on
        # a single node
        cluster:
          domainName: "onezone.localhost"
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
            bucketQuota: 1024
            nodes:
              - "n1"
        onezone:
          # Assign custom name to the Onezone instance
          name: "ONEZONE-DEMO"
          domainName: "onezone-example.com"
          # Automatically obtain SSL certificates
          letsEncryptEnabled: true
        onepanel:
          # Create initially 1 administrator and 1 regular user
          users:
            "admin":
              password: "password"
              userRole: "admin"
            "user":
              password: "password"
              userRole: "regular"
```

To install the necessary Docker images on the machine run:

```sh
$ docker-compose -f /opt/onedata/onezone/docker-compose.yml pull
```

### Configuring authentication methods

Currently **Onezone** supports 2
general modes of authentication, i.e.: basic authentication and OpenID
Connect. Default configuration supports only basic authentication using Onepanel accounts.
For configuring authentication using OpenID Providers see [here](openid_saml_configuration.md). For configuring Google IdP see this [tutorial](openid_saml_configuration/google_idp_tutorial.md).

### Security and recommended firewall settings
**Onezone** service requires several ports (`53`,`53/UDP`,`80`,`443`,`9443`) to be opened for proper operation. Some of these ports can be limited to internal network, in particular `9443` for **Onepanel** management interface.

Furthermore, on all nodes of **Onezone** deployment where Couchbase instance
is deployed, it exposes several additional ports. This means that the
Couchbase [security guidelines](https://developer.couchbase.com/documentation/server/4.6/security/security-intro.html)
should be also followed.

For more information about ports setup see [Firewal setup](./firewall_setup.md)


### DNS records setup for subdomain delegation

Onezone has its own DNS server, automatically deployed on every node of the cluster. Its purpose is to simplify cluster scaling and allow for subdomain delegation for Oneproviders - i.e. allocating subdomains of the Onezone domain for the providers and resolving DNS queries in their name. In order for subdomain delegation to work properly, it is necessary to set up DNS zone delegation in the DNS server responsible for your domain. It should delegate management of the Onezone domain and its subdomains to the Onezone DNS server. 

Assuming your Onezone domain is `onezone-example.com` you need to set following records at your DNS provider:
NS records pointing to ns1.onezone.org, ns2.onezone.org etc.. Number of those subdomains depends on the number of nodes in your Onezone cluster. If there are more than 10 nodes, only the first ten should be inserted.

> NOTE: even if your installation uses a single node, subdomain `ns2.` is also available in order to comply with some registrars minimum of two NS records. This option can be configured in the `app.config` file. Glue records, i.e. A records with names `ns1.onezone-example.com`, `ns2.onezone-example.com` etc. and IPs of your cluster nodes.

Example: your Onezone deployment (onezone-example.com) consists of 3 nodes:
`150.1.0.2`, `150.1.0.3` and `150.1.0.4`

In the DNS responsible for the `onezone-example.com` domain (usually the server is administered by the domain provider, or there is a dedicated DNS server for your organization), set the following records:

| Domain           | Record | Value            |
| ---------------- | ------ | ---------------- |
| onezone-example.com.     | NS     | ns1.onezone-example.com. |
| onezone-example.com.     | NS     | ns2.onezone-example.com. |
| onezone-example.com.     | NS     | ns3.onezone-example.com. |
| ns1.onezone-example.com. | A      | 150.1.0.2        |
| ns2.onezone-example.com. | A      | 150.1.0.2        |
| ns3.onezone-example.com. | A      | 150.1.0.2        |

This way, all queries concerning the `onezone-example.com` domain will be routed to the DNS servers running on Onezone cluster nodes.


## Running

Docker based installation can be conveniently managed using a **systemd** service unit. Simply create a file with path `/etc/systemd/system/onezone.service` and the following content:

```
[Unit]
Description=Onezone Service
After=docker.service
Requires=docker.service

[Service]
ExecStartPre=/usr/bin/docker-compose -f /opt/onedata/onezone/docker-compose.yml down
ExecStart=/usr/bin/docker-compose -f /opt/onedata/onezone/docker-compose.yml up --abort-on-container-exit --no-recreate
ExecStop=-/usr/bin/docker-compose -f /opt/onedata/onezone/docker-compose.yml down
Restart=always

[Install]
WantedBy=multi-user.target
```

Then the **Onezone** service can be managed using standard `systemctl` command:
```
# Enable Onezone service on machine startup
$ sudo systemctl enable onezone.service

# Start Onezone service
$ sudo systemctl start onezone.service
$ sudo systemctl status onezone.service
...
May 25 23:25:32 localhost docker-compose[13499]: onezone-1                  | Congratulations! onezone has been successfully started.

# Stopping Onezone service
$ sudo systemctl stop onezone.service

# Restarting Onezone service while keeping all persistent files
$ sudo systemctl restart onezone.service

# Remove Onezone data files
$ sudo systemctl stop onezone.service
$ sudo rm -rf /opt/onedata/onezone/persistence/*
```

### Logs
In case of issues, both **Onepanel** and **Onezone** logs should be checked and included in any reported issues.

**Onepanel** logs should be consulted for issues related to Onezone deployment or adding new users. **Onezone** logs should contain errors related to accessing user spaces, registering providers and others.

The following directories contain the logs:

```
# Onepanel logs
$ sudo ls /opt/onedata/onezone/persistence/var/log/oz_panel/
cmd.log debug.log error.log info.log run_erl.log

# Onezone logs
sudo ls /opt/onedata/onezone/persistence/var/log/oz_worker/
debug.log error.log info.log run_erl.log
```


