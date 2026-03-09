# Docker Compose (batch mode)

## Prerequisites

Make sure the host intended for deployment is [properly set up][].

## Customizing Oneprovider Docker Compose script

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
  node1.oneprovider.internal:
    # Oneprovider Docker image version
    image: onedata/oneprovider:xRELEASExVERSIONx
    # Hostname (in this case the hostname inside Docker network)
    hostname: node1.oneprovider.internal
    # The IP of VM need to be placed below under extra_hosts, for example:
    # - "node1.oneprovider.internal:10.20.30.5"
    extra_hosts:
      - "node1.oneprovider.internal:YOUR_HOST_IP"
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
      # Tell Onepanel to read configuration from environment variable
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
          domainName: "oneprovider.internal"
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
          # Domain will be "my-provider.onedata.example.com"
          subdomain: my-provider 
          # Alternatively:
          # Automatically register this Oneprovider in Onezone without subdomain delegation
          # subdomainDelegation: false
          # domain: "oneprovider.yourdomain.com"

        onezone:
          # Address of the Onezone at which this Oneprovider will register
          domainName: "onedata.example.com"
```

Modify the file according to your needs. The minimal changes must include:

* `YOUR_HOST_IP`
* `ONEPANEL_EMERGENCY_PASSPHRASE`
* `onezone.domainName` (not `cluster.domainName`)
* `oneprovider.geoLatitude`
* `oneprovider.geoLongitude`
* `oneprovider.name`
* `oneprovider.adminEmail`
* `oneprovider.subdomain` if `subdomainDelegation` == `true`
* `oneprovider.domain` if `subdomainDelegation` == `false`.

In the above example, it is assumed that a POSIX storage backend is available under the 
directory `/mnt/data`. To install the necessary Docker images on the machine run:

```sh
docker compose -f /opt/onedata/oneprovider/docker-compose.yml pull
```

## Setting up certificates

Since release 18.02.0-beta5, Oneprovider supports automatic certificate
management backed by Let's Encrypt. To use this option, it is only necessary
to enable this feature in Oneprovider Docker Compose configuration file
([see above][docker-compose]) or via GUI.

If you prefer to obtain and install certificates for Oneprovider service
manually, modify the Docker Compose file to mount PEM files inside the
container using paths listed in the section [Web certificate][].

## Security and recommended firewall settings

Oneprovider service requires several TCP ports (`80`,`443`, `4443`, `6665`,`9443`) to be opened for proper operation.
Some of these ports can be limited to internal network, in particular `9443` for **Onepanel** management interface.

Furthermore, there are some additional ports exposed on all hosts of the Oneprovider deployment where you have
deployed a Couchbase instance. Thus, we strongly advise following the Couchbase [security guidelines][security-intro].

For more information about ports setup, consult the section [Network and firewall][].

## Running Docker based installation using systemd

Docker based installation can be conveniently managed using a **systemd** service unit. Simply create a
`/etc/systemd/system/oneprovider.service`:

```systemd
[Unit]
Description=Oneprovider Service
After=docker.service
Requires=docker.service

[Service]
ExecStartPre=/usr/bin/docker compose -f /opt/onedata/oneprovider/docker-compose.yml down
ExecStart=/usr/bin/docker compose -f /opt/onedata/oneprovider/docker-compose.yml up --abort-on-container-exit --no-recreate
ExecStop=-/usr/bin/docker compose -f /opt/onedata/oneprovider/docker-compose.yml down
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

[properly set up]: ../prerequisites.md

[security-intro]: https://docs.couchbase.com/server/current/install/install-security-bp.html

[network and firewall]: ../configuration/network-and-firewall.md

[web certificate]: ../configuration/web-certificate.md

[docker-compose]: #customizing-oneprovider-docker-compose-script
