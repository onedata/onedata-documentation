# User Quickstart
This step-by-step guide shows how to create a Onedata account, support your home space and upload files to your account.

## Set up an account
1. Go to [Onedata login page](https://onedata.org/login) and sign in using one of the supported login methods.
2. Follow the instructions presented to you at first login.
3. You will see the *onezone* page, were you can navigate through your spaces.

<!--
For more information about different ways of authenticating with Onedata, see [Authentication](..//authentication.md).
For more information about managing your account, see [Account management](account_management.md).
-->
## Supporting the Home Space
At the first login, a **home space** is created for you.
Like every space, at the beginning it has quota size of 0MB. You have to request storage support with certain limit (e.g. 5GB) from some storage provider (or setup your own Oneprovider service) to be able to store any files in this space.

In the left panel of *Onezone* page you can find the *Manage Client Tokens* tab. There you can create new storage support request token and copy it to your clipboard. You need to send this token to one of storage providers who use Onedata and ask to support your space.

After having your space supported by at least 1 provider, the provider will appear on the map on *Onezone* page. Click on the provider icon on the map and click on the button "Go to your files". You will be redirected to [Oneprovider web interface](../user_guide.md), where you can manage your files and [more](../user_guide.md).

## Uploading files
1. Click the **Upload file** button - which is the 4th icon in the top row.
2. Click the **Select files** and using the system dialog select files you wish to upload. You can select multiple files.
3. Click the **Start upload** button in order to start the upload.
4. Observe the *progress bars*. The first one tracks the overall progress of the upload, the second tracks the progress of the file currently being uploaded.

## Accessing files
Once you have some files in your space, you can access them using the web interface or the Onedata virtual file system through the Oneclient tool.

TODO


## Next steps
After you are comfortable using basic file operations in your home space, see the [User Guide](../user_guide.md) and learn how to work with multiple spaces and perform some more advanced actions.
