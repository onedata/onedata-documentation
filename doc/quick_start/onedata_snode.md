# Onedata Single-node 

The goal of this tutorial is for you to run a fully working simple Onedata installation on your own machine. We will show you how to deploy and use Onedata components using [Docker](www.docker.com) images we prepared. To simplify the process we use [docker-compose](https://docs.docker.com/compose/) tool.

Here’s a diagram of the various parts in play in this tutorial to help you understand how pieces fit with one another. Use this as a reference as we progress through the tutorial; it should all make sense by the time we get to the end. 


If you haven't done it already, please read the [Overview](overview.md) to get familiar with basic Onedata concepts.

Setup and Requirements
--

In order to follow this quickstart you will need [Docker](www.docker.com) and [docker-compose](https://docs.docker.com/compose/) installed on your machine. Follow 



Create a docker-compose file
--
The first step is to write a docker-compose file. Save this file in a folder called `onedata_tutrial1/` with the filename `docker-compose.yml`:

Next, create a file, also within `onedata_tutrial1/` named `docker-compose.yml`. A docker-compose file describes the services that we want to deploy and how they fit together. We will start with a basic template that we will expand in the later steps. 

~~~yaml
version: '2.0'

services:

  onezone:
    image: onedata/onezone:3.0.0-beta6
    restart: always
    hostname: node.onedata.org
                 
  oneprovider:
    image: onedata/oneprovider:3.0.0-beta6
    restart: always
    hostname: localhost.localdomain
    
  oneclient:
    image: onedata/oneclient:3.0.0-beta6
~~~

To run Onedata locally on your Docker, you need 3 services:

- Onezone, a communication hub of Onedata system
- Oneprovider, a component that connects storage to Onedata
- Oneclient, a command line client used to access your files in Onedata

Configure Onezone
--
All Onedata services come with a dedicated web-based configuration wizard that guides the user through configuration process. Insted of using the wizard, in this scenario we will inject all the configuration options needed by Onezone by means of environmental variables in the docker-compose file. That includes domain names, hostnames and the name of the Onezone we are deploying. 

The Onezone part of the docker-compose file looks like this:

~~~yaml
  onezone:
    image: onedata/onezone:3.0.0-beta6
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
~~~


Configure Oneprovider
--
Oneprovider serivce exposes your storage to Onedata system. Create the directory `onedata_tutrial1/data` where Onedata will store your data and which will be used by Oneprovider. 
In `docker-compose` we specify a docker volume:

~~~yaml
volumes:
      - "onedata_tutrial1/data:/mnt/data"
~~~

You are adviced to replace the relative path `onedata_tutrial1/data` to the absolute path to your data directory. Additionaly we link Oneprovider to Onezone with `onezone:onedata.org` link option. Lastly we supply Oneprovider configuration in form of environmental variables.

The Oneprovider part of the docker-compose file looks like this:

~~~yaml
  oneprovider:
    image: onedata/oneprovider:3.0.0-beta6
    restart: always
    hostname: localhost.localdomain
    volumes:
      - "/mnt/data:/mnt/data"
    links:
      - onezone:onedata.org
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
~~~

You can set the geo_longitude and geo_latitude variables to your location so that your porivder is presented nicely on the map in the graphical user interface. 

Configure Oneclient
-
Oneclient allows you to mount your Onedata spaces in the POSIX file system tree (using fuse as a backend). Create a directory `onedata_tutrial1/myspaces `. By supplying a volume option to Docker: 

~~~yaml
volumes:
      - "/mnt/oneclient:onedata_tutrial1/myspaces"
~~~

You are adviced to replace the relative path `onedata_tutrial1/oneclient` to the absolute path to your data directory. Your spaces will be visible in that directory.

The Oneclient part of the docker-compose file looks like this:

~~~yaml
  oneclient:
    image: onedata/oneclient:3.0.0-beta6
    privileged: true
    volumes:
      - "/mnt/oneclient:onedata_tutrial1/myspaces"
    links:
      - oneprovider:node.dev.local
    environment:
      PROVIDER_HOSTNAME: node.dev.local
      ONECLIENT_AUTHORIZATION_TOKEN: XXXXXXXXXX
~~~
  
Putting it all together
--
In last step we will add custom network configuration to your docker-compose file, to have a better convrol over what ip-s will be assigned to Onedata services. 

The network configuration part of the docker-compose file:

~~~yaml
networks:
  onedata:
    driver: bridge
    ipam:
      driver: default
      config:
        - subnet: 172.20.100.0/24
          gateway: 172.20.100.1
          ip_range: 172.20.100.0/30
  oneprovider:
    driver: bridge
    ipam:
      driver: default
      config:
        - subnet: 172.20.1.0/24
          gateway: 172.20.1.1
          ip_range: 172.20.1.0/30
~~~

If goes well with Docker, onezone service should be reachable with `172.20.100.2` and that's the only ip adress you will need. 

The complete docker-compose file with additional network configuration addedd to all the services looks as follows:

~~~yaml
version: '2.0'

services:
  onezone:
    image: onedata/onezone:3.0.0-beta6
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
          
  oneprovider:
    image: onedata/oneprovider:3.0.0-beta6
    restart: always
    hostname: localhost.localdomain
    volumes:
      - "/mnt/data:/mnt/data"
    links:
      - onezone:onedata.org
    networks:
      - oneprovider
      - onedata
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
  oneclient:
    image: onedata/oneclient:3.0.0-beta6
    privileged: true
    volumes:
      - "/tmp/oneclient:/root/.local/share/myspaces"
      - "/mnt/oneclient:/mnt/oneclient"
      - "/mnt/data:/mnt/data"
    links:
      - oneprovider:node.dev.local
    environment:
      PROVIDER_HOSTNAME: node.dev.local
      ONECLIENT_AUTHORIZATION_TOKEN: $ONECLIENT_AUTHORIZATION_TOKEN

networks:
  onedata:
    driver: bridge
    ipam:
      driver: default
      config:
        - subnet: ${NETWORK}.100.0/24
          gateway: ${NETWORK}.100.1
          ip_range: ${NETWORK}.100.0/30
  oneprovider:
    driver: bridge
    ipam:
      driver: default
      config:
        - subnet: 172.20.1.0/24
          gateway: 172.20.1.1
          ip_range: 172.20.1.0/30
~~~

Running the docker-compose file
--
To run your Onedata installtion we will need to start all three servces in right order. First navigate to `onedata_tutrial1/` and execute:

~~~bash
$ docker-compose up onezone
Congratulations! onezone has been successfully started.
~~~
Wait for the confirmation message that Onezone service is up.

Open next terminal window and start Oneprovider service.

~~~bash
$ docker-compose up oneproivder
Congratulations! oneproivder has been successfully started.
~~~

Making HTTPS Green (optional)
--
In order to make https work you can add these entriesto your `/etc/hosts` file:

~~~bash
<IP onezone>    onedata.org # (required by OpenID)
<IP onezone>    node1.onezone.dev.local
<IP onepvodier> node1.oneprovider.dev.local
~~~

That will start all 3 services. You open another terminal and determing if you have 3 docker containers running with `docker ps` command. 

Storing and accessing your files with Oneclient
---
In order to access your files in Onedata with Oneclient you need an access token. In order to get one navigate to 

~~~
https://<onezone_ip>/#/onezone?expand_tokens=true
or
https://onedata.org/#/onezone?expand_tokens=true
if you setup /etc/hosts properly
~~~

Copy generated token, open another terminal window and navigate to `onedata_tutorial1/`. Ensure that you created directory `onedata_tutorial1/myspaces`. Next run following commands 

~~~bash
$ export ONECLIENT_AUTHORIZATION_TOKEN=<paste token>
$ docker-compose up oneclient
~~~

You can now store your files in Onedata system under `onedata_tutorial1/myspaces` directory. To experiment with Onedata explore onedata web-interface under `https://onedata.org/` and try to upload some data.

