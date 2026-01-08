# Graphical wizard

The prerequisites for this installation method are the same as for the installation using
batch mode. With this method, the Onedata cluster is configured and deployed by using the
Onepanel Web GUI.

## Customizing Oneprovider Docker Compose script

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

## Deploying the Onedata cluster using the Web GUI

Start a web browser and open [https://localhost:9443][localhost-onepanel]. If the browser is not started on the provider
node, replace localhost with the IP of the node. You may need to accept the SSL security exception in your browser.
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

<!-- references -->

[Running Docker based installation using systemd]: docker-compose.md#running-docker-based-installation-using-systemd

[screen-installation-gui-new-onepanel]: ../../../../images/admin-guide/oneprovider/installation/installation-gui-new-onepanel.png

[screen-installation-gui-passphrase]: ../../../../images/admin-guide/oneprovider/installation/installation-gui-passphrase.png

[screen-installation-gui-welcome]: ../../../../images/admin-guide/oneprovider/installation/installation-gui-welcome.png

[screen-installation-gui-cluster-deployment]: ../../../../images/admin-guide/oneprovider/installation/installation-gui-cluster-deployment.png

[screen-installation-gui-registration]: ../../../../images/admin-guide/oneprovider/installation/installation-gui-registration.png

[screen-installation-gui-registration-2]: ../../../../images/admin-guide/oneprovider/installation/installation-gui-registration-2.png

[screen-installation-gui-ip-address-setup]: ../../../../images/admin-guide/oneprovider/installation/installation-gui-ip-address-setup.png

[screen-installation-gui-dns-setup]: ../../../../images/admin-guide/oneprovider/installation/installation-gui-dns-setup.png

[screen-installation-gui-web-certificate]: ../../../../images/admin-guide/oneprovider/installation/installation-gui-web-certificate.png

[screen-installation-gui-storages]: ../../../../images/admin-guide/oneprovider/installation/installation-gui-storages.png

[screen-installation-gui-storages-2]: ../../../../images/admin-guide/oneprovider/installation/installation-gui-storages-2.png

[space support]: ../configuration/space-support.md

[screen-installation-gui-cluster-configured-successfully]: ../../../../images/admin-guide/oneprovider/installation/installation-gui-cluster-configured-successfully.png

[localhost-onepanel]: https://localhost:9443
