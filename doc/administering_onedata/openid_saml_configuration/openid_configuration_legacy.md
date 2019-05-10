# OpenID Configuration

**Config version 1**

This documentation is deprecated and valid for Onezone versions `18.02.0-rc11` or older.
Other versions can be found [here](../openid_saml_configuration.md).


<!-- toc -->

OpenID is the main authentication method used in Onedata. It allows users to reuse their accounts from other websites such as social networks or infrastructure portals.

When configuring Onedata, it is necessary to decide which identity providers should be trusted by the Onezone service. This can be achieved by editing the `/var/lib/oz_worker/auth.config` file on Onezone node. Example file is presented below. All unnecessary login methods can be removed and all tokens must be replaced with actual application tokens and secrets for each service:


## Supported authentication sources
Below is the list of supported OpenID providers. Most such services, require registration of each application (such as Onezone services). Sections below describe how to this for each supported service.

For OpenID services, the login validation endpoint for any Onezone instance has to configured in the OpenID providers setup. The URL is:

```
https://<ONEZONE_HOST>/validate_login
```


### Basic auth
In order to support HTTP basic authentication, it is necessary to add the following section to the `auth.config` file:

```Erlang
    {basicAuth, [ ]},
```

The actual user accounts need to be creating using [Onepanel API](../creating_user_accounts.md).

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
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        % Provider specific config
        {xrds_endpoint, <<"https://iam-test.indigo-datacloud.eu/.well-known/openid-configuration">>}
    ]}
```

### EGI OIDC
This section is specific to EGI OpenID Connect [authentication service](https://aai.egi.eu/oidc).

```Erlang
    {egi, [
        {auth_module, auth_egi},
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        % Provider specific config
        {xrds_endpoint, <<"https://aai.egi.eu/oidc/.well-known/openid-configuration">>}
    ]}
```

### Advanced features

#### Group Mapping

For each IdP it is possible to define a method for mapping groups and roles from IdP to Onedata. In order to enable this for a selected IdP a special section `group_mapping` has to be added to an IdP definition. For example:

```erlang
    {egi, [
        {auth_module, auth_egi},
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        {group_mapping, [
          {enabled, true},
          {vo_group_id, <<"VOGroup">>},
          {attributes_to_map, [
            {<<"groups">>, team, {nested, <<"/">>}},
            {<<"roles">>, role, flat}
          ]},
         {super_group, <<"ParentGroup">>}
     ]}
```

The fields in this section have the following meaning:

* `enabled` - activates group mapping feature
* `vo_group_id` - the Id of the VO group in IdP
* `attributes_to_map` - the definition of the mapping defined in the form `{IDP_ATTRIBUTE_NAME, ONEDATA_ROLE_TYPE, IDP_GROUP_PATTERN}`, where:
  * IDP_ATTRIBUTE_NAME - name of the attribute in IdP metadata e.g. *group*, *role*
  * ONEDATA_ROLE_TYPE - one of: `organization | unit | team | role`
  * IDP_GROUP_PATTERN - this can have the following values:
    * `flat` - the group name from IdP is copied as-is to Onedata
    * `nested`, <<"SEP">> - where SEP is a separator string used to tokenize the group name from IdP and build a nested group in Onedata, where each token from the original name will be a separate group in Onedata
* `super_group` - the super group in VO, can be set to `undefined` if not necessary

#### Authentication delegation using third party IdP tokens

Onezone service supports authentication delegation using other trusted OAuth
providers. When enabled it allows users to directly use their access tokens
(e.g. from GitHub) to authenticate with Onedata.

In order to enable this feature for specific IdP, an `authority_delegation` entry
has to be added to the OpenID config, for instance:

```Erlang
    {github, [
        {auth_module, auth_github},
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        {authorize_endpoint, <<"https://github.com/login/oauth/authorize">>},
        {access_token_endpoint, <<"https://github.com/login/oauth/access_token">>},
        {user_info_endpoint, <<"https://api.github.com/user">>},
        {user_emails_endpoint, <<"https://api.github.com/user/emails">>},
        {authority_delegation, [
            {enabled, true}, {token_prefix, <<"github:">>}]},
      ]}
```

In such case, users can directly access the Onedata API's
using access tokens obtained from external OAuth provider by prefixing the
access token.

In case of API calls this prefix needs to be added before the third party token
in `X-Auth-Token` header, for instance:
```
  X-Auth-Token: github:e72e16c7e42f292c6912e7710c838347ae178b4a
```
where `e72e16c7e42f292c6912e7710c838347ae178b4a` is the actual GitHub access token.

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
            <<"https://api.github.com/user/emails">>},
        {authority_delegation, [
            {enabled, true}, {token_prefix, <<"github:">>}]},
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
        {xrds_endpoint,
            <<"https://iam-test.indigo-datacloud.eu/.well-known/openid-configuration">>},
        {authority_delegation, [
            {enabled, true}, {token_prefix, <<"indigo:">>}]},
    ]},

    {egi, [
        {auth_module, auth_egi},
        {app_id, <<"APP_ID">>},
        {app_secret, <<"APP_SECRET">>},
        % Provider specific config
        {xrds_endpoint, <<"https://aai.egi.eu/oidc/.well-known/openid-configuration">>},
        {authority_delegation, [
            {enabled, true}, {token_prefix, <<"egi:">>}]},
    ]}
].
```