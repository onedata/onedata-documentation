# User Quickstart
{% if book.draft %}
> This document serves as a entry point for the documentation for a user who is eager to start using onedata, regardles of his understanding of onedata concepts.

> In this document we show step by step how to login into onedata, how to create a space and how to upload files.

> All of it is quite easy.
{% endif %}

This step-by-step guide shows how to create an Onedata account, support your default space and upload files to your account.

## Set up an account
1. Go to [Onedata login page](https://onedata.org/login) and sign in using one of supported services.
2. Follow the prompts presented to you at first login.

You will see the *Manage account* page, were you can edit your account details.

For more information about different ways of authenticating with Onedata, see [Authentication](solutions/authentication.md).
For more information about manging your account, see [Account management](account_management.md).

## Supporting the Default Space
At the first login, a **default space** is created for you.
Like every space, at the beginning it has quota size of 0MB. You have to support your default space with storage space to increase the quota and be able to use it.

At the bottom of the *Manage account* you find a **token**. You need to send this token to one of Onedata providers and ask to support your space.

After having your space supported, press *Click here to check again* link. Click on the button "Go to your files". You will be redirected to Onedata [web interface](user_guide.md), where you can manage you files and [more](user_guide.md).

## Uploading file
1. Click the **Upload file** button - which is the second icon from the left located just above the *spaces* directory.
2. Click the **Select files** and using the system dialog select files you wish to upload. You can select multiple files.
3. Click the **Start upload** button in order to start the upload.
4. Observe the *progress bars*. The first one tracks the overall progress of the upload, the second tracks the progress of the file being uploaded.

## Next steps
After you are comfortable using basic file operation in your default space, see the [User Guide](user_guide.md) learn how to work with multiple spaces.
