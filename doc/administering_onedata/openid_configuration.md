# OpenID Configuration

OpenID is the main authentication method used in Onedata. It allows users to reuse their accounts from other websites such as social networks or infrastructure portals.

When configuring Onedata, it is necessary to decide which identity providers should be trusted by the Onezone service. This can be achieved by editing the `/var/lib/oz_worker/auth.config` file on Onezone node. Example file is presented below. All unnecessary login methods can be removed and all tokens must be replaced with actual application tokens and secrets for each service:

## Supported authentication sources
Below is the list of supported OpenID providers. Most such services, require registration of each application (such as Onezone services). Sections below describe how to this for each supported service.

### Basic auth
In order to support HTTP basic authentication, it is necessary to add the following section to the `auth.config` file:

```Erlang
    {basicAuth, [ ]},
```

The actual user accounts need to be creating using [Onepanel API](./creating_user_accounts.md).

### Google
The configuration entry for Google authentication service is presented below.

```Erlang
    {google, [
        % Standard config
        {auth_module, auth_google},
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        % Provider specific config
        {xrds_endpoint,
            <<"https://accounts.google.com/.well-known/openid-configuration">>}
    ]},
```

The credentials can be retrieved from Google on the Open ID [credentials generation page](https://console.developers.google.com/apis/credentials).

### Facebook

```Erlang
    {facebook, [
        % Standard config
        {auth_module, auth_facebook},
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        % Provider specific config
        {authorize_endpoint,
            <<"https://www.facebook.com/dialog/oauth">>},
        {access_token_endpoint,
            <<"https://graph.facebook.com/oauth/access_token">>},
        {user_info_endpoint,
            <<"https://graph.facebook.com/me">>}
    ]},
```

The credentials can be retrieved from Facebook on Open ID [credentials generation page](https://developers.facebook.com/docs/marketing-api/authentication).

### Github

```Erlang
    {github, [
        % Standard config
        {auth_module, auth_github},
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        % Provider specific config
        {authorize_endpoint,
            <<"https://github.com/login/oauth/authorize">>},
        {access_token_endpoint,
            <<"https://github.com/login/oauth/access_token">>},
        {user_info_endpoint,
            <<"https://api.github.com/user">>},
        {user_emails_endpoint,
            <<"https://api.github.com/user/emails">>}
    ]},
```

The credentials can be retrieved from Github on Open ID [credentials generation page](https://developer.github.com/v3/oauth/).

### Dropbox

```Erlang
    {dropbox, [
        {auth_module, auth_dropbox},
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        % Provider specific config
        {authorize_endpoint,
            <<"https://www.dropbox.com/1/oauth2/authorize">>},
        {access_token_endpoint,
            <<"https://api.dropbox.com/1/oauth2/token">>},
        {user_info_endpoint,
            <<"https://api.dropbox.com/1/account/info">>}
    ]},
```

The credentials can be retrieved from Github on Open ID [credentials generation page](https://developer.github.com/v3/oauth/).

### PLGrid
The PLGrid section is specific to storage providers who want to support users of [Polish National Grid Infrastructure](http://www.plgrid.pl/en).
```Erlang
    {plgrid, [
        % Standard config
        {auth_module, auth_plgrid},
        % Provider specific config
        {xrds_endpoint,
            <<"https://openid.plgrid.pl/gateway">>},
        {logout_endpoint,
            <<"https://openid.plgrid.pl/logout">>}
    ]},
```

### INDIGO IAM
This section is specific to the storage providers supporting the [INDIGO-DataCloud](https://www.indigo-datacloud.eu/) platform.
```Erlang
    {indigo, [
        {auth_module, auth_indigo},
        {app_id, <<"...">>},
        {app_secret, <<"...">>},
        % Provider specific config
        % Provider specific config
        {xrds_endpoint, <<"https://iam-test.indigo-datacloud.eu/.well-known/openid-configuration">>}
    ]}
```

## Complete example

The complete auth.conf file is presented below. It is specified directly in [Erlang](https://www.erlang.org/). For new deployments edit this file, remove all unsupported entries and replace all `APP_ID and `APP_SECRET` occurences with your actual OpenID tokens.

```Erlang

%% List of supported auth providers and their config.
[
    {basicAuth, [

    ]},

    {google, [
        % Standard config
        {auth_module, auth_google},
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        % Provider specific config
        {xrds_endpoint,
            <<"https://accounts.google.com/.well-known/openid-configuration">>}
    ]},

    {facebook, [
        % Standard config
        {auth_module, auth_facebook},
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        % Provider specific config
        {authorize_endpoint,
            <<"https://www.facebook.com/dialog/oauth">>},
        {access_token_endpoint,
            <<"https://graph.facebook.com/oauth/access_token">>},
        {user_info_endpoint,
            <<"https://graph.facebook.com/me">>}
    ]},

    {github, [
        % Standard config
        {auth_module, auth_github},
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        % Provider specific config
        {authorize_endpoint,
            <<"https://github.com/login/oauth/authorize">>},
        {access_token_endpoint,
            <<"https://github.com/login/oauth/access_token">>},
        {user_info_endpoint,
            <<"https://api.github.com/user">>},
        {user_emails_endpoint,
            <<"https://api.github.com/user/emails">>}
    ]},

    {dropbox, [
        {auth_module, auth_dropbox},
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        % Provider specific config
        {authorize_endpoint,
            <<"https://www.dropbox.com/1/oauth2/authorize">>},
        {access_token_endpoint,
            <<"https://api.dropbox.com/1/oauth2/token">>},
        {user_info_endpoint,
            <<"https://api.dropbox.com/1/account/info">>}

    ]},

    {plgrid, [
        % Standard config
        {auth_module, auth_plgrid},
        % Provider specific config
        {xrds_endpoint,
            <<"https://openid.plgrid.pl/gateway">>},
        {logout_endpoint,
            <<"https://openid.plgrid.pl/logout">>}
    ]},

    {indigo, [
        {auth_module, auth_indigo},
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        % Provider specific config
        % Provider specific config
        {xrds_endpoint, <<"https://iam-test.indigo-datacloud.eu/.well-known/openid-configuration">>}
    ]}
].
```



