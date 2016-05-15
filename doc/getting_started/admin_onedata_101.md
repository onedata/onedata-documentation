# Administrator quick start
This section presents a step by step guide to deploy a local Onedata deployment for test purposes a one of our predefined scenarios defined in Docker Compose. More information on these examples can be found at: [](https://github.com/onedata/getting-started)

## Get sample deployment scenarios

Clone Onedata *getting-started* repository: `https://github.com/onedata/getting-started`
and navigate to `scenarios/2_0_oneprovider_onezone` directory.

In this scenario all the necessary configuration is injected into Onedata services during installation (see *docker-compose* configuration files for details). The resulting setup will be ready to work immediately after starting docker containers.

## Setup Onedata services
We will use `run-onedata.sh` for running Onedata docker containers. For more information about the script run `run-onedata.sh --help`.

Onedata services depend on each other, after each run wait for a conformation message that service has succesfully started before continuing. 

### Onezone
To start Onezone service open separate terminal window and execute:
```bash=
./run_onedata.sh --onezone 
```

### Oneprovider
To run Oneprovider service open another termial window and execute:
```bash=
./run_onedata.sh --oneprovider
```

### Add `onedata.org` to /etc/hosts

In order for Onedata authentication - based on OpenID - to work properly on a local machine you need to modify your /etc/hosts file so that you web-browser would see onedata services under `onedata.org` domain.

```
# Onedata configuration
<onezone_ip>      onedata.org # (required by OpenID)
<onezone_ip>      node1.onezone.dev.local
<oneprovider_ip>  node1.oneprovider.dev.local
```

Use following commands to extract IP addresses of Onezone and Oneprovider services:
```bash=
docker inspect 20oneprovideronezone_node1.onezone.dev.local_1 | grep "IPAddress" # for onezone
docker inspect 20oneprovideronezone_node1.onezone.dev.local_1 | grep "IPAddress" # for oneprovider
```

## Use Onedata

Navigate to `https://onedata.org` (assuming you modified your `/etc/hosts` file) and register with your local Onedata installation using one of the available authentication methods. From this point you have a fully working local Onedata installation. 

Additionally Oneprovider management inferface is avaiable at `https://node1.oneprovider.dev.local:9443`.

Refer to [User quickstart](user_onedata_101.md) to quickly start using Onedata.

If you happened to run into problems, please contact us on our support chat or write us an email. All the necessary information is available on `https://onedata.org/support`.


