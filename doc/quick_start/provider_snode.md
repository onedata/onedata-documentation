<!-- toc -->

# Quickstart

To help you get up to speed with Onedata we provide a number of tutorials that allow you to deploy your own complete Onedata installation or just Oneprovider environment and become a part of Onedata worldwide ecosystem. 

Scenarios vary in complexity (&#x1F4D7; easy,  &#x1F4D8; medium, &#x1F4D5; hard) and some of them requirers &#x1F30D; public ip address to work.

You can either follow this quickstart or jump streight to onedata-quickstart [github repo]() where you will find source files for all scenarios presented here.

>The goal of these tutorials is for you to run a fully working simple Onedata installation on your own machine.

## Requirments
This tutorial uses docker images of Onedata components, to follow it you need [Docker](www.docker.com) 1.11+ and [docker-compose](https://docs.docker.com/compose/) installed on your machine. Onedate does provide *rpm* and *deb* packages, however they are not covered by this tutorial.

## Quickstart Git Repository
All the source files presented in this quickstart are aviable in Onedta quicstart repository on [github](https://github.com/groundnuty/onedata-getting-started). If you know docker and want to quickly get your hands on Onedata, you can follow a readme [github](https://github.com/groundnuty/onedata-getting-started) and use this document as a reference guide.

## Scenarios
You can start using Onedata by either installing Oneprovider and registering with [onedata.org](onedata.org) or by deploying your own isolated Onedata installation. The first although easier, requirers your machine to have a &#x1F30D; public ip address and a number of [open ports]().

In the following scenarios we will need three Onedata components and three `docker-compose.yaml` files, each designed to set up a particular service. We will call them:

- `docker-compose-onezone.yaml` for Onezone service
- `docker-compose-oneprovider.yaml` for Oneprovider service
- `docker-compose-oneclient.yaml` for Oneclient 

each of them can be started using a docker-compose command:

```bash=
docker-compose -f "docker-compose-<component_name>.yaml" up
```

### Scenario 1: Oneprovider using Onedata.org &#x1F4D7; &#x1F30D;
In this section we will guide you how to setup a single-node and a multi-node Oneprovider installations. If you need more information about Oneprovider please refer to [oneprovider readme]().

Here’s a diagram of the various parts in play in this scenario to help you understand how pieces fit with one another. Use this as a reference as we progress through the scenario; it should all make sense by the time we get to the end. 

<p align="center">
<img src="../img/Onedata101_provider.svg">
</p>

#### Setting up Oneprovider
Although Oneprovider is a cluster solution we will start by deploying it with one node only.

To do that we will need a `docker-compose-oneprovider.yaml` to setup Oneprovider. Here is baisc template that we will expand in the later steps:

<pre><code class="yaml">version: '2.0'

services:
  oneprovider:
    image: docker.onedata.org/oneprovider:{{ book.quickstart.docker.versions.oneprovider }}
    restart: always
    hostname: localhost.localdomain
</code></pre>

##### Attaching storage volume
The main purpose of Oneprovider is to expose your storage resources to Onedata system. To do that using a docker image, you need to specify a volume to a docker-compose file:

```
volumes:
      - "onedata_tutrial1/data:/mnt/data"
``` 

You are adviced to replace the relative path onedata_tutrial1/data to the absolute path to your data directory. Modified `docker-compose-oneprovider.yaml`  will look like that:

<pre><code class="yaml">version: '2.0'

services:
  oneprovider:
    image: docker.onedata.org/oneprovider:{{ book.quickstart.docker.versions.oneprovider }}
    restart: always
    hostname: localhost.localdomain
    volumes:
      - "onedata_tutrial1/data:/mnt/data"
</code></pre>


> Additionaly we link Oneprovider to Onezone with onezone:onedata.org link option. Lastly we supply Oneprovider configuration in form of environmental variables.


##### Configuring Oneprovider
Oneprovider docker image can be configured and initialized using a [web wizard]() or by supplying it with configuration file. In this scenario we will supply the content of the configuration file using docker environmental variables. The detailed information on the syntax of Oneprovider configuration file can be found [here]().

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

You can set the `geo_longitude` and `geo_latitude` variables to your location so that your porivder is presented nicely on a map in Onezone web interface.


##### Adding a second Oneprovider node &#x1F4D8;
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

##### Running Oneprovider 

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

##### Registering Oneprovider with onedata.org &#x1F30D;

#### Accessing your data with Oneclient
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

##### Mount Point Configuration
To mount your data in your local filesystem you need to create mount point `onedata_tutrial1/myspaces` add it as a docker volume:

```
volumes:
      - "/mnt/oneclient:onedata_tutrial1/myspaces
```

##### Authentication with Onedata
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

##### Running Oneclient

Copy generated token, open another terminal window and navigate to onedata_tutorial1/. Ensure that you created directory onedata_tutorial1/myspaces. Next run following commands

```bash
$ docker-compose -f docker-compose-oneclient.yml up oneclient
```
You can now store your files in Onedata system under `onedata_tutorial1/myspaces` directory. To experiment with Onedata explore onedata web-interface under `https://onedata.org/` and try to upload some data.

##### Troubleshooting
Open another terminal and determing if you have 2 docker containers running with `docker ps` command. 


### Scenario 2: Installing complete Onedata &#x1F4D8;
 
In this section you will learn how to deploy a fully functional Onedata installation that can work independely of Onedata.org.

In this section we will guide you how to setup a single-node and a multi-node Oneprovider installations. If you need more information about Oneprovider please refer to oneprovider readme.

Here’s a diagram of the various parts in play in this scenario to help you understand how pieces fit with one another. Use this as a reference as we progress through the scenario; it should all make sense by the time we get to the end. 

<p align="center">
<img src="../img/Onedata101.svg">
</p>

In this scenario we will leverage docker compose configuration files form [Scenario 1](). If you have problem following please refer to [Scenario 1]().

In [Scenario 1]() you used globale Onezone service accessible under `ondata.org`. Now you need to start with setting your own Onezone service. 

To run Onedata locally on your Docker, you need three services:

- Onezone, a communication hub of Onedata system
- Oneprovider, a component that connects storage to Onedata
- Oneclient, a command line client used to access your files in Onedata


#### Making HTTPS Green (optional)

In order to make https work between your local Onezone and Oneprovider installations you can add these entries to your `/etc/hosts` file:

~~~bash
<IP onezone>    onedata.org # (required by OpenID)
<IP onezone>    node1.onezone.dev.local
<IP onepvodier> node1.oneprovider.dev.local
~~~

####Setting up Onezone
We will start by deploying a single-node Onezone installtion using a following `docker-compose-onezone.yaml` as a template: 

<pre><code class="yaml">version: '2.0'
services:
  onezone:
    image: docker.onedata.org/onezone:{{ book.quickstart.docker.versions.onezone }}
    restart: always
    hostname: node.onedata.org
</code></pre>

##### Configuring Onezone
All Onedata services come with a dedicated web-based configuration wizard that guides the user through configuration process. Insted of using the wizard, in this scenario we will inject all the configuration options needed by Onezone by means of environmental variables in the docker-compose file. That includes domain names, hostnames and the name of the Onezone we are deploying.

All possible configuration options of Onezone are described [here]().

The `docker-compose-onezone.yaml` with configuration looks like this:

<pre><code class="yaml">version: '2.0'
  onezone:
    image: docker.onedata.org/onezone:{{ book.quickstart.docker.versions.onezone }}
    restart: always
    hostname: node.onedata.org
    environment:
      ONEPANEL_BATCH_MODE: 'true'
      ONEZONE_CONFIG: |
        cluster:
          domain_name: "onedata.org"
          nodes:
            node:
              hostname: "node"
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
          settings:
            open_files_limit: 65535
            processes_limit: 65535
        onezone:
          name: "example"
</code></pre>

##### Adding a second Onezone node &#x1F4D8;
In order to extend Onezone with extra node we you need to add a second service to 1docker-compose-onezone.yaml1 and modify Oneprovider configuration in `docker-compose-oneprovider.yaml` so that it accounts for extra nodes.

The complete `docker-compose-onezone.yaml` with double node Oneprovider cluster looks like that:

<pre><code class="yaml">version: '2.0'
  node1.onezone:
    image: docker.onedata.org/onezone:{{ book.quickstart.docker.versions.onezone }}
    restart: always
    hostname: node1.onedata.org
    environment:
      ONEPANEL_BATCH_MODE: 'true'
      ONEZONE_CONFIG: |
        cluster:
          domain_name: "onedata.org"
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
          settings:
            open_files_limit: 65535
            processes_limit: 65535
        onezone:
          name: "example"
          
 node2.onezone:
    image: docker.onedata.org/onezone:{{ book.quickstart.docker.versions.onezone }}
    restart: always
    hostname: node.onedata.org
</code></pre>


##### Running Onezone
In order to start onezone nodes you need to run docker-compose. In each case wait for a confirmation message that oneprovider service was setup correctly.
To

```bash
# For singe-node installation
$ docker-compose -f "docker-compose-onezone.yaml" up onezone
Congratulations! onezone has been successfully started.

# For double node installation
$ docker-compose -f "docker-compose-onezone.yaml" up node1.onezone
Congratulations! node1. onezone has been successfully started.
$ docker-compose -f "docker-compose-onezone.yaml" up node2.onezone
Congratulations! node2. onezone has been successfully started.
```

#### Setting up Oneprovider
The process of setting up Oneprovider service either single-node or multi-node is the same as in [Scenario 1](). You just need to modify address of the Onezone service to point to your local installation. 

The complete `docker-compose-onezone.yaml` for single node Oneprovider  that will connect with your Onezone service looks like this:

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
          domain_name: "node1.onezone"
</code></pre>

For Oneprovider with two nodes that is correct `docker-compose-onezone.yaml`:

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
          domain_name: "node1.onezone"
    
  node2.oneprovider:
    image: docker.onedata.org/oneprovider:{{ book.quickstart.docker.versions.oneprovider }}
    hostname: node1.oneprovider.dev.local
    volumes: # shared volume required for mulit-node storage access verification
          - "onedata_tutrial1/data:/mnt/data"
</code></pre>

To run Oneprovider use the same commands as in [Scenario 1](), remember to ensure that Onezone service is running before you start Oneprovider.


#### Accessing your data with Oneclient
The process is exacly the same as in [Scenario 1]()

### Scenario 3: Setting up Onedata using a Wizard &#x1F4D5;
In Scenarios 1 and 2 you injected configuration to Onedata services via docker environmental vairiables. However the recomended way to for setting Onedata is to use Onepanel wizard, that allows for installation, configuration and management of Onezone and Oneprovider clusters. 

In order to you Onepanel wizard you need to remove the 

```yaml
ONEPANEL_BATCH_MODE: 'true'
```
line from docker compose configuration files, then all the following configuration will be ignored. You can find correct docker compose files for this scenario in [quick-start repo](). 

For more instructions on installing Onezone and Oneprovider with Onepanel wizard, follow [Onezone Installation]() and [Oneproider Installation]() guides.
