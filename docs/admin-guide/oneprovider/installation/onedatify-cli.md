# Onedatify CLI wizard

Onedatify is an easy-to-use script for automating the deployment of Docker-based Oneprovider instance. The script
automatically registers the Oneprovider instance to a selected Onezone service and allows for interactive
configuration of a storage backend with eventual enabling import of legacy data sets.

## Prerequisites

In addition to the general prerequisites, this method also requires access to an existing user account in the Onezone
instance, with which Oneprovider should register.

## Deploying Oneprovider

Follow carefully the following steps.

### Creating a new space in Onezone

::: tip NOTE
Skip this step if you want to support an existing space.
:::

The first step to deploy Oneprovider using Onedatify script is to create a new space, which will be automatically
supported by the new Oneprovider instance.

Open the Web GUI and in the **Data** tab, click on the **+** (plus sign in the circle) button.

![screen-onedatify-create-space][]

### Generating one-line Onedatify command in Onezone

Navigate to the **Data > *Space name* > Providers** view. Click on the **Add support** button in the main view.

Select the tab **Deploy your own Oneprovider**:

![screen-onedatify-deploy-provider-command][]

and copy the generated command.

::: tip NOTE
If you would like to expose a directory containing an existing data set, then select the tab **Expose existing data
set** and copy the generated command.
:::

### Run the command on the target host

Paste the copied command in the terminal on the Oneprovider machine (as superuser or as a user with sudo privileges).

Check the prerequisite list and confirm to proceed to the next step:

![screen-onedatify-step-1][]

If necessary, the Onedatify script will ask for permission to install all necessary dependencies including Docker and
Docker Compose.

After the installation of dependencies is complete, the script will ask several questions and suggest default
setting for each one:

![screen-onedatify-step-2][]

The progress can be monitored on a separate terminal using the following command:

```sh
journalctl -u onedatify.service -f
```

After the deployment is complete, the following message will be shown, with connection details for administration panel
for the Oneprovider instance:

![screen-onedatify-step-5][]


<!-- references -->

[screen-onedatify-create-space]: ../../../../images/admin-guide/oneprovider/installation/onedatify-create-space.png

[screen-onedatify-deploy-provider-command]: ../../../../images/admin-guide/oneprovider/installation/onedatify-deploy-provider-command.png

[screen-onedatify-step-1]: ../../../../images/admin-guide/oneprovider/installation/onedatify-step-1.png

[screen-onedatify-step-2]: ../../../../images/admin-guide/oneprovider/installation/onedatify-step-2.png

[screen-onedatify-step-5]: ../../../../images/admin-guide/oneprovider/installation/onedatify-step-5.png
