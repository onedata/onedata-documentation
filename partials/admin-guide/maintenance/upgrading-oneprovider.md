## Upgrading

The Oneprovider service can be upgraded to a higher version, with some constraints described in the [Upgrades & compatibility][] chapter.

The software implements any required upgrade procedures, which are run when you start a new version on top of pre-existing persistence data originating from an older version. These procedures may take a long time, but are idempotent and resistant to the service restarts.

### Using the Onedatify

To upgrade the Oneprovider, which has been set up using the [Onedatify][]:

1. Log on into the Oneprovider host using SSH. 

2. Check the current version of the Oneprovider service, e.g. using the REST API:

```sh
curl https://127.0.0.1/api/v3/oneprovider/configuration | jq .version
```


3. Pull the docker image to make the upgrade smoother. In this example we want to upgrade our Oneprovider to version 21.02.9:

```sh
docker pull onedata/oneprovider:21.02.9
```

4. Run the upgrade command. The service will be stopped, backed up, and started on a newer docker image:

```sh
onedatify upgrade -v onedata/oneprovider:21.02.9
```

5. Inspect the created backup (optional):

```sh
ls /opt/onedata/oneprovider-backups
```

6. Check if the Oneprovider version changed to the target version.

```sh
curl https://127.0.0.1/api/v3/oneprovider/configuration | jq .version
```

### 🚧 Under construction! 🚧

The detailed description of the upgrading process is coming soon.