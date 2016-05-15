# Oneprovider deployment in Onedata.org zone
In this section we will guide you how to setup a single-node &#x1F4D7; and a multi-node  &#x1F4D8; Oneprovider installations, connected to public [onedata.org]() zone. To follow this guide you will need a machine with a public ip &#x1F30D; address and a number of [open ports](../../adminstering_onedata/provider_installation.md)
 <!-- If you need more information about Oneprovider please refer to [oneprovider readme]().-->

<!-- toc -->

Here’s a diagram of the various parts in play in this scenario to help you understand how pieces fit with one another. Use this as a reference as we progress through the scenario; it should all make sense by the time we get to the end. 

<p align="center">
<img src="../../img/Onedata101_provider.svg">
</p>

## Setting up Oneprovider
Although Oneprovider is a cluster solution we will start by deploying it on single node for now.

To do that we will need a `docker-compose-oneprovider.yaml` to setup Oneprovider. Here is a basic template that we will expand in the later steps:

<pre><code class="yaml">version: '2.0'

services:
  oneprovider:
    image: docker.onedata.org/oneprovider:{{ book.quickstart.docker.versions.oneprovider }}
    restart: always
    hostname: localhost.localdomain
</code></pre>

### Attaching storage volume
The main purpose of Oneprovider is to expose your storage resources to Onedata system. To do that using a Docker image, you need to specify a volume in a docker-compose file:

```
volumes:
      - "onedata_tutrial1/data:/mnt/data"
``` 

You are adviced to replace the relative path onedata_tutrial1/data with the absolute path to your data directory. Modified `docker-compose-oneprovider.yaml`  will look like that:

<pre><code class="yaml">version: '2.0'

services:
  oneprovider:
    image: docker.onedata.org/oneprovider:{{ book.quickstart.docker.versions.oneprovider }}
    restart: always
    hostname: localhost.localdomain
    volumes:
      - "onedata_tutrial1/data:/mnt/data"
</code></pre>


> Additionaly we link Oneprovider to Onezone with onezone:onedata.org link option. Lastly we supply Oneprovider configuration in the form of environmental variables.


### Configuring Oneprovider
Oneprovider Docker image can be configured and initialized using a [web wizard]() or by supplying it with configuration file. In this scenario we will supply the content of the configuration file using docker environmental variables. The detailed information on the syntax of Oneprovider configuration file can be found [here]().

The complete `docker-compose-oneprovider.yaml` for a single-node cluster looks like this:
<pre><code class="yaml">version: '2.0'

services:
  oneprovider:
    image: docker.onedata.org/oneprovider:{{ book.quickstart.docker.versions.oneprovider }}
    restart: always
    hostname: localhost.localdomain
    volumes:
          - "onedata_tutrial1/data:/mnt/data"
    environment:
      ONEPANEL_BATCH_MODE: 'true'
      ONEPROVIDER_CONFIG: |
        cluster:
          domain_name: "localdomain"
          nodes:
            node:
              hostname: "localhost"
          manager:
            default_node: "node"
            nodes:
              - "node"
          worker:
            nodes:
              - "node"
          database:
            nodes:
              - "node"
          storage:
            NFS:
              type: "POSIX"
              mount_point: "/mnt/data"
          settings:
            open_files_limit: 65535
            processes_limit: 65535
        oneprovider:
          register: true
          name: "provider"
          geo_longitude: 19.945
          geo_latitude: 50.0647
        onezone:
          domain_name: "onedata.org"
</code></pre>

You can set the `geo_longitude` and `geo_latitude` variables to your location so that your provider is presented nicely on a map in Onezone web interface.


### Adding a second Oneprovider node &#x1F4D8;
In order to extend Oneprovider with extra node we you need to add a second service to `docker-compose-oneprovider.yaml` and modify Oneprovider configuration in `docker-compose-oneprovider.yaml` so that it accounts for extra nodes.

The complete `docker-compose-oneprovider.yaml` with double node Oneprovider cluster looks like that:

<pre><code class="bash">version: '2.0'

services:
  node1.oneprovider:
    image: docker.onedata.org/oneprovider:{{ book.quickstart.docker.versions.oneprovider }}
    restart: always
    hostname: localhost.localdomain
    volumes:
          - "onedata_tutrial1/data:/mnt/data"
    environment:
      ONEPANEL_BATCH_MODE: 'true'
         cluster:
          domain_name: "oneprovider.dev.local"
          nodes:
            node1:
              hostname: "node1"
            node2:
              hostname: "node2"
          manager:
            default_node: "node1"
            nodes:
              - "node1"
              - "node2"
          worker:
            nodes:
              - "node1"
              - "node2"
          database:
            nodes:
              - "node1"
              - "node2"
          storage:
            NFS:
              type: "POSIX"
              mount_point: "/tmp/data"
        oneprovider:
          register: true
          name: "example"
          redirection_point: "https://node1.oneprovider.dev.local"
        onezone:
          domain_name: "onedata.org"
    
  node2.oneprovider:
    image: docker.onedata.org/oneprovider:{{ book.quickstart.docker.versions.oneprovider }}
    hostname: node1.oneprovider.dev.local
    volumes: # shared volume required for mulit-node storage access verification
          - "onedata_tutrial1/data:/mnt/data"
</code></pre>

### Running Oneprovider 

In order to start oneprovider nodes you need to run docker-compose. In each case wait for a confirmation message that oneprovider service was setup correctly.

```bash
# For singe-node installation
$ docker-compose -f "docker-compose-oneprovider.yaml" up oneprovider
Congratulations! oneprovider has been successfully started.

# For double node installation
$ docker-compose -f "docker-compose-oneprovider.yaml" up node1.oneprovider
Congratulations! node1.oneprovider has been successfully started.
$ docker-compose -f "docker-compose-oneprovider.yaml" up node2.oneprovider
Congratulations! node2.oneprovider has been successfully started.
```

### Registering Oneprovider with onedata.org &#x1F30D;

## Accessing your data with Oneclient
[Oneclient]() is a a command line, FUSE-based client that allows you to mount the data you store in Onedata in POSIX filesystem tree.

Additionaly, Oneclient docker image exposes your data to your machine via. NFS and SMB shares, what allows to efficient access to your data even on Windows and OSX sytems, where docker service runs in a virtual machine. For more information refere to oneclient docker image [description]().

To mount for 
Oneclient allows you to mount your Onedata spaces in the POSIX file system tree (using fuse as a backend). Create a directory onedata_tutrial1/myspaces. By supplying a volume option to Docker:

The basic `docker-compose-oneclient.yml` template for Oneclient looks like this:
<pre><code class="yaml">version: '2.0'
services:
  oneclient:
    image: docker.onedata.org/oneclient:{{ book.quickstart.docker.versions.oneclient}}
 </code></pre>

### Mount Point Configuration
To mount your data in your local filesystem you need to create mount point `onedata_tutorial1/myspaces` add it as a docker volume:

```
volumes:
      - "/mnt/oneclient:onedata_tutrial1/myspaces
```

### Authentication with Onedata
Furthermore to authenticate with Onedata, oneclient needs a certificate or an authentication token. 

> In order to access your files in Onedata with Oneclient you need an access token. In order to get one navigate to
> https://<onezone_ip>/#/onezone?expand_tokens=true
> or
> https://onedata.org/#/onezone?expand_tokens=true
> if you setup /etc/hosts properly

For more information about how to get an authentication token or upload your certificate [see]() [Onezone documentation]().

Authentication token and the name of the provider we just setup is passed as a configuration using docker environmental vairables. The complete `docker-compose-oneclient.yml` looks like this:

<pre><code class="yaml">version: '2.0'
oneclient:
    image: docker.onedata.org/oneclient:{{ book.quickstart.docker.versions.oneclient }}
    privileged: true
    volumes:
      - "/mnt/oneclient:onedata_tutrial1/myspaces"
    links:
      - oneprovider:node.dev.local
    environment:
      PROVIDER_HOSTNAME: node1.oneprovider
      ONECLIENT_AUTHORIZATION_TOKEN: XXXXXXXXXX # Paste authetication token here
</code></pre>

### Running Oneclient

Copy generated token, open another terminal window and navigate to onedata_tutorial1/. Ensure that you created directory onedata_tutorial1/myspaces. Next run following commands

```bash
$ docker-compose -f docker-compose-oneclient.yml up oneclient
```
You can now store your files in Onedata system under `onedata_tutorial1/myspaces` directory. To experiment with Onedata explore onedata web-interface under `https://onedata.org/` and try to upload some data.

### Troubleshooting
Open another terminal and determing if you have 2 docker containers running with `docker ps` command. 
