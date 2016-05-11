# Onedata Admin 101

For Onedata Admin 101, we will cover installation of full Onedata: onezone, oneprovider and oneclient packages using docker images and docker compose. We have prepared docker compose configuration for each of Onedata services.

## Get Sources

Clone Onedata getting stared repo: `https://github.com/onedata/getting-started`
and navigate to `scenarios/2_0_oneprovider_onezone` directory.

In this scenario all the necessary configuration is injected in to Onedata services during installation (see docker-compose configuration files). The resulting setup will be ready to work just after starting docker containers.

## Setup Onedata
You will use `run-onedata.sh` for running Onedata docker containers. For more information about the script run `run-onedata.sh --help`.

Onedata services depend on each other, after each run wait for a conformation message that service has succesfully started before continuing. 

### Onezone
To run Onezone service open separate termial window and execute:
```bash=
./run_onedata.sh --onezone 
```

### Oneprovider
To run Oneprovider service open another termial window and execute:
```bash=
./run_onedata.sh --oneprovider
```

### Add `onedata.org` to /etc/hosts

In order for Onedata installation to work properly you need to modify you /etc/hosts file so that you web-browser would see onedata services under `onedata.org` domain.

```
# Onedata configuration
<onezone_ip>      onedata.org # (required by OpenID)
<onezone_ip>      node1.onezone.dev.local
<oneprovider_ip>  node1.oneprovider.dev.local
```

Use following commands to extract IP addreses of Onezone and Oneprovider services:
```bash=
docker inspect 20oneprovideronezone_node1.onezone.dev.local_1 | grep "IPAddress" # for onezone
docker inspect 20oneprovideronezone_node1.onezone.dev.local_1 | grep "IPAddress" # for oneprovider
```

## Use Onedata

Navigate to `https://onedata.org` (assumign you modified your `/etc/hosts` file) and register with your local Onedata installation using one of the authentication method. From this point you hava a fully working Onedata installation. 

Additionaly Oneprovider management inferface is aviable at `https://node1.oneprovider.dev.local:9443`.

Refer to [User Onedata 101](user_onedata_101.md) and [User Guide](../user_guide.md) for more information on using Onedata. 

If you happed to run into problems, please  us on our support chat or write us an email. All the necessary information is available on `https://onedata.org/support`.


