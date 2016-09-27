# Administrator quick start
This section presents a step by step guide to deploy a local Onedata deployment for test purposes using Docker Compose and our helper bash scripts. 

More advanced examples can be found at the official [Onedata Getting Started repository](https://github.com/onedata/getting-started).

To use this scenario you will need:
~~~
docker => 1.11
docker-compose => 1.7
~~~
installed on your machine.

## Get deployment scenario files
Clone Onedata *getting-started* repository: `https://github.com/onedata/getting-started`

```bash=
git clone https://github.com/onedata/getting-started
```

and navigate to `scenarios/2_0_oneprovider_onezone` directory.

```bash=
cd getting-started/scenarios/2_0_oneprovider_onezone
```

In this scenario all the necessary configuration is injected into Onedata services during installation (see *docker-compose* configuration files for details). The resulting setup will be ready to work immediately after starting Docker containers.

## Setup Onedata services
We will use `run_onedata.sh` for running Onedata docker containers. For more information about the script run `run_onedata.sh --help`.

Onedata services depend on each other, after each run wait for a confirmation message that service has successfully started before continuing. 

### Onezone
To start Onezone service open separate terminal window and execute:
```bash=
./run_onedata.sh --zone 
```
write down a zone container ip that will be printed on the screen.

### Oneprovider
To run Oneprovider service open another terminal window and execute:
```bash=
./run_onedata.sh --provider
```
write down a provider container ip that will be printed on the screen.

As this point you have a fully functional Onedata installation preconfigured with values found in `scenarios/2_0_oneprovider_onezone/docker-compose-onezone.yml` and `scenarios/2_0_oneprovider_onezone/docker-compose-oneprovider.yml`.

## Use Onedata
Open Onezone service web interface under IP address of the Onezone Docker container and use a *basic auth* method to login into Onezone. Default credentials specified in the `docker-compose-onezone.yml` file are:
~~~
user: admin
password: password
~~~

Additionally Management interfaces of Oneprovider and Onezone are available at:
~~~
https://<ip or domain of your Oneprovider container>:9443
https://<ip or domain of your Onezone container>:9443
~~~

Refer to [User quickstart](user_onedata_101.md) to quickly start using Onedata.

If you happened to run into problems, please report an issue on [GitHub](https://github.com/onedata/getting-started/issues) or contact us on our support chat. All the necessary information is available on `https://onedata.org/support`.


