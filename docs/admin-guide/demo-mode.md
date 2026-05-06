# Demo mode

\[toc]\[1]

<!-- TODO VFS-11848 add examples regarding oneclient, onedatafs, onedatarestfs, onedatafilerestclient -->

<!-- TODO VFS-11848 comprehensive example with OZ, OP and OC and a single await on OC -->

<!-- TODO VFS-11848 cross-references from different sections here and back 
                    (interfaces, quickstarts)
-->

<!-- TODO VFS-11766 
    Consider adding a script to packages.onedata.org, used like this:

    curl https://packages.onedata.org/demo.sh | bash -s --providers 3 --clients 3

    that would do the stuff described here and give you a nice output where to find
    the deployed services.
-->

<!-- TODO VFS-11766 link to the section about releases (when it's there) -->

The Onedata software is released as a range of docker images that run its different
components. **Since version 21.02.5**, these images include an easy-to-run **demo** mode
that starts Onedata services and components with a minimal, but fully functional config,
providing a “hello world” deployment.

The demo mode is useful when:

1. You wish to get familiar with Onedata in a sandbox environment, without any account
   registration or complicated setup. Then, see the instructions for
   [running in the foreground][].

2. You wish to start a minimal Onedata environment for the needs of automated processes —
   for example, integration tests of your middleware/scripts/applications that use Onedata
   as the storage layer. Check out the guide for [running in the background][], or if you
   prefer, see this [easy-to-adopt example][comprehensive example].

## Default demo setup

The demo environment is configured in the following way:

1. All services are single-node and use IP-based domains. They run on a minimal DB
   RAM quota, providing a lightweight deployment not suitable for heavy workloads.

2. All services use self-signed (untrusted) TLS certificates; you will need to implicitly
   trust the certificates in the web browser, and use options allowing insecure
   connections in the client applications.

3. There is one predefined user, with username: `admin`, and password: `password`.

4. There is one predefined demo space, called `demo-space`, with always identical space
   ID: `cb274b2b8bb1750d9be37dd4a3eb7014chb175`.

5. Any number of Oneprovider services can be started. They will all automatically support
   the demo space. Providers get some predefined names and geographical locations. Make
   sure to **start at least two** to be able to test in action the flagship Onedata
   features for **distributed data management**.

## Running in the foreground

To get the simplest possible demo environment, run the two below shell commands in two
different terminals (can be in parallel, which makes the setup faster). Monitor the logs
for hints and to find out details about the setup process.

```bash
docker run --rm -it --name oz_test onedata/onezone:xRELEASExVERSIONx demo
```

```bash
until OZ_IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' oz_test 2>/dev/null) && \
[ -n "$OZ_IP" ]; do sleep 1; done
docker run --rm -it --name op_test1 onedata/oneprovider:xRELEASExVERSIONx demo $OZ_IP
```

## Accessing the Web GUI

After the two services are successfully set up, you will see green logs with instructions
on how to log in to the demo environment, like below.

```
-------------------------------------------------------------------------
Demo Oneprovider service is ready! Visit the Onezone GUI in your browser:
  URL:      https://172.17.0.3
  username: admin
  password: password
  note:     you must add an exception for the untrusted certificate

From there, you can access the demo space and manage the Oneprovider cluster.
To interact with the APIs or mount a Oneclient, use the provider IP: 172.17.0.4
-------------------------------------------------------------------------
```

When you enter the URL in your browser:

1. Use credentials from the logs to log in.
2. Upon the “No connection to Oneprovider” error, visit the server URL (as suggested) to
   accept the self-signed certificate.

For documentation on Onedata
concepts and features, consult the [user guide][] and [admin guide][].

::: danger WATCH OUT
Avoid redeploying the demo space on the same IP address if you already accepted the certificate.

Your browser will detect that on the same IP address there is now a different server with a new certificate. It will block your access due to the security reasons.

If you really need to do it, use incognito mode or another browser.
:::

## Distributed (multi-provider) environment

You can start any number of Oneprovider services; just rerun the above command, but change
the `--name` parameter to a unique value. All the providers will support the same demo
space, **start at least two** to be able to test in action the flagship Onedata features
for **distributed data management**:

```bash
until OZ_IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' oz_test 2>/dev/null) && \
[ -n "$OZ_IP" ]; do sleep 1; done
docker run --rm -it --name op_test2 onedata/oneprovider:xRELEASExVERSIONx demo $OZ_IP
```

::: tip NOTE
The demo command for `oneprovider` takes one required argument — the `onezone` IP address,
which is already taken care of in the above command.
:::

## Running in the background

Run the dockers just like for the [foreground][running in the foreground], but add the
`--detach` (or `-d`) option:

```bash
docker run --rm --detach -it --name oz_test onedata/onezone:xRELEASExVERSIONx demo
```

```bash
until OZ_IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' oz_test 2>/dev/null) && \
[ -n "$OZ_IP" ]; do sleep 1; done
docker run --rm --detach -it --name op_test1 onedata/oneprovider:xRELEASExVERSIONx demo $OZ_IP
```

Use the following command to block the process until the provider is set up and ready to be used:

```bash
docker exec op_test1 await-demo
```

Run it for all the providers to be sure that your automated
process can start using the demo space in Onedata right away.

::: tip NOTE
In some scenarios, you may want to only check that the Onezone is operational, without checking the rest of the demo space.
In such cases, run:

```bash
docker exec oz_test await
```

:::

::: warning
While running in the background, you won't be able to see the instruction how to log in. Use this command to get the URL:

```bash
echo "URL: https://$(docker inspect -f '{{.NetworkSettings.IPAddress}}' oz_test)"
```

Then use it to [access the Web GUI][accessing the web gui]. The credentials will be the same.
:::

## Acquiring an access token

An access token will be required to use the [REST API][] or any client other than the
[Web GUI][] (e.g. [Oneclient][] or [OnedataFS][]).

You can simply acquire the token using the [graphical wizard][token via gui] in the Web
GUI, or for an automated process, run the `demo-access-token` command for any of the
containers (`onezone` or `oneprovider`; they work the same):

```bash
docker exec oz_test demo-access-token
# or
docker exec op_test1 demo-access-token
```

The above commands will give you a non-restricted access token valid for a week.

## Comprehensive example

The below script will start a simple demo environment with one provider, wait for it to be
ready, and create a test file in the demo space using the REST API. This can be a nice
starting point for creating an integration test setup for your middleware that uses
Onedata:

```bash
docker run --rm -it -d --name oz_test onedata/onezone:xRELEASExVERSIONx demo
OZ_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' oz_test)
docker run --rm -it -d --name op_test1 onedata/oneprovider:xRELEASExVERSIONx demo $OZ_IP
OP_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' op_test1)
docker exec op_test1 await-demo
ACCESS_TOKEN=$(docker exec op_test1 demo-access-token)
DEMO_SPACE_ID="cb274b2b8bb1750d9be37dd4a3eb7014chb175"
FILE_NAME="test$RANDOM.txt"
RESULT=$(curl -ks -H "x-auth-token: $ACCESS_TOKEN" \
    -X POST "https://$OP_IP/api/v3/oneprovider/data/$DEMO_SPACE_ID/children?name=$FILE_NAME" \
    -H "Content-Type: application/octet-stream" -d "hello world\n")
# below JSON parsing method is definitely not elegant, 
# but bear with us since we want a portable example not depending on 'jq'
FILE_ID=$(echo $RESULT | cut -d':' -f2 | tr -d '"}')
echo "All done! Created a file called \"$FILE_NAME\" in the demo space; view it here:"
echo ""
echo "https://$OZ_IP/#/action/file/show/$FILE_ID"
```

After running the script, you can [access the Web GUI][accessing the web gui].

## Data access using Python

Onedata provides few interfaces to access its virtual file system from Python, namely:

* [OnedataRESTFS][] — high level pure Python client implemented using [PyFilesystem2][] and
  [OnedataFileRestClient][],
* [OnedataFileRestClient][] — low level pure Python client, which is a wrapper over Onedata
  [File access and management API][], used as basis for [OnedataRESTFS][],
* [OnedataFS][] — Python wrapper for native binary Onedata communication protocol, implemented
  in C++ (installation of the Python library requires several C++ dependencies beforehand).

In this section we'll present how to set up and use the [OnedataRESTFS][] library, which is
recommended for ease of installation and use.

#### Installation

Firstly, make sure your demo environment is up and running (with at least one provider).

The installation includes creation of temporary `venv` environment for Python dependencies:

```bash
# Setup venv
virtualenv -p /usr/bin/python3 venv
. venv/bin/activate

# Install OnedataRESTFS
pip install fs.onedatarestfs

# Downgrade the setuptools dependency for OnedataRESTFS
# This is needed because PyFilesystem2 isn't actively mantained 
pip install setuptools==81.0.0

# Export necessary OnedataRESTFS arguments as environment variables
export OZ_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' oz_test)
export ACCESS_TOKEN=$(docker exec op_test1 demo-access-token)

# Finally start Python3 shell
python3
```

#### Usage

Since this deployment does not have trusted SSL certificates, we have to mute the SSL
warnings:

```python
>>> import requests
>>> requests.packages.urllib3.disable_warnings()
```

Now we can create an instance of `OnedataRESTFS` client as follows:

```python
>>> import os
>>> from fs.onedatarestfs import OnedataRESTFS
>>> onedata_onezone_host = os.getenv("OZ_IP")       
>>> onedata_access_token = os.getenv("ACCESS_TOKEN")
>>> odfs = OnedataRESTFS(onedata_onezone_host, onedata_access_token, verify_ssl=False)
```

Now we can test if this works, for instance by listing available spaces, which are simply
top level directories in the virtual file system hierarchy:

```python
>>> odfs.listdir('')
['demo-space']
```

or create a simple text file:

```python
>>> odfs.writetext('/demo-space/file.txt', 'TEST')
>>> odfs.readtext('/demo-space/file.txt')
'TEST'
```

For more information on how to use a `OnedataRESTFS` instance, see the [OnedataRESTFS][]
chapter.

## Retaining persistence between restarts

**Since version 25.0**, demo mode supports persistence so that data and configuration
survive container restarts. Use the same workflow as [running in the foreground][], but
add a fixed hostname and volume mounts.

Onezone with persistence:

```bash
docker run --rm -it --name oz_test -h oz_test -v /tmp/oz-pers:/volumes/persistence onedata/onezone:xRELEASExVERSIONx demo
```

Oneprovider with persistence:

```bash
until OZ_IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' oz_test 2>/dev/null) && \
[ -n "$OZ_IP" ]; do sleep 1; done
docker run --rm -it --name op_test1 -h op_test1 -v /tmp/op-pers:/volumes/persistence -v /tmp/op-storage:/volumes/storage onedata/oneprovider:xRELEASExVERSIONx demo $OZ_IP
```

When using persistence:

1. Set the hostname explicitly (e.g. `-h oz_test`, `-h op_test1`) and **keep it the same**
   between consecutive runs. Otherwise the service may fail to start without clear logs.
2. Use the **same** host directory for persistence on every run (e.g. `/tmp/oz-pers` for
   Onezone, `/tmp/op-pers` for Oneprovider).
3. For Oneprovider, use the **same** host directory for POSIX storage on every run
   (e.g. `/tmp/op-storage`).

<!-- References -->

[running in the foreground]: #running-in-the-foreground

[running in the background]: #running-in-the-background

[accessing the web gui]: #accessing-the-web-gui

<!-- TODO VFS-11766 rethink the overview/quickstart approach -->

<!-- TODO VFS-11766 is it better to link to overview or quickstart? -->

[user guide]: ../user-guide/quickstart.md

[admin guide]: ../admin-guide/overview.md

[Web GUI]: ../user-guide/interfaces/web-file-browser.md

[REST API]: ../user-guide/rest-api.md

[File access and management API]: https://onedata.org/#/home/api/stable/oneprovider?anchor=tag/File-Path-Resolution

[Oneclient]: ../user-guide/interfaces/oneclient.md

[OnedataFS]: ../user-guide/interfaces/onedata-fs.md

[OnedataRESTFS]: ../user-guide/interfaces/onedata-rest-fs.md

[OnedataFileRestClient]: ../user-guide/interfaces/onedata-file-rest-client.md

[PyFilesystem2]: https://github.com/PyFilesystem/pyfilesystem2

[token via gui]: ../user-guide/tokens.md#gui-guide

[comprehensive example]: #comprehensive-example
