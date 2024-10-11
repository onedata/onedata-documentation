# Demo mode

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
OZ_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' oz_test)
docker run --rm -it --name op_test1 onedata/oneprovider:xRELEASExVERSIONx demo $OZ_IP
```

After the two services are successfully set up, you will see green logs with instructions
on how to log in to the demo environment, like below. For documentation on Onedata
concepts and features, consult the [user guide][] and [admin guide][].

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

## Distributed (multi-provider) environment

You can start any number of Oneprovider services; just rerun the above command, but change
the `--name` parameter to a unique value. All the providers will support the same demo
space, **start at least two** to be able to test in action the flagship Onedata features
for **distributed data management**:

```bash
OZ_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' oz_test)
docker run --rm -it --name op_test2 onedata/oneprovider:xRELEASExVERSIONx demo $OZ_IP
```

::: tip NOTE
The demo command for `oneprovider` takes one required argument — the `onezone` IP address,
which is already taken care of in the above command.
:::

## Running in the background

Run the dockers just like for the [foreground][running in the foreground], but add the
`--detach` (or `-d`) option.

Use the built-in commands of the images to block the process until the demo environment
is all set up and ready to be used:

```bash
docker exec op_test1 await-demo
```

It's sufficient to run the above for all the providers to be sure that your automated
process can start using the demo space in Onedata right away. However, in some scenarios
you may also find the `await` command for Onezone useful:

```bash
docker exec oz_test await
```

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

::: tip TIPS
When you visit the above URL:

1. Use `admin : password` to log in.
2. Upon the “No connection to Oneprovider” error, visit the server URL (as suggested) to
   accept the self-signed certificate.

:::

<!-- References -->

[running in the foreground]: #running-in-the-foreground

[running in the background]: #running-in-the-background

<!-- TODO VFS-11766 rethink the overview/quickstart approach -->

<!-- TODO VFS-11766 is it better to link to overview or quickstart? -->

[user guide]: ../user-guide/quickstart.md

[admin guide]: ../admin-guide/overview.md

[Web GUI]: ../user-guide/web-file-browser.md

[REST API]: ../user-guide/rest-api.md

[Oneclient]: ../user-guide/oneclient.md

[OnedataFS]: ../user-guide/onedatafs.md

[token via gui]: ../user-guide/tokens.md#gui-guide

[comprehensive example]: #comprehensive-example
