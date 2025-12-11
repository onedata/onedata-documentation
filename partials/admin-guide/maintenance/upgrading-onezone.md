## Upgrading

The Onezone service can be upgraded to a higher version, with some constraints described in the [Upgrades & compatibility][] chapter.

### Using the `onedata-deployments`

To upgrade the Onezone, which has been set up using the `onedata-deployments` toolkit:

1. Stop the deployment:

```sh
./onezone.sh stop
```

2. Make the backup of the persistence directory, e.g. using the `rsync`:

```sh
sudo rsync -avs /opt/onedata/onedata-deployments ~/backup-25.12.10
```

3. Change the Onezone image version in the `docker-compose.yml` file.

4. Start the deployment:

```sh
./onezone.sh start
```

### 🚧 Under construction! 🚧

The detailed description of the upgrading process is coming soon.