# SSL certificate management

All Onedata components require certain X.509 certificates to be installed in specific folders in order to properly handle TLS connections with clients.

The following sections detail certificates required by each Onedata service.

All keys and certificates must be in PEM format. Whenever certificates for given service change, the service must be restarted.


## Onezone

| Web Server private key |
|:-----------------|
| `/etc/oz_worker/certs/gui_key.pem` |
| This is the private key of the certificate for Onezone service for securing the HTTPS traffic. |

| Web Server public certificate |
|:-----------------|
| `/etc/oz_worker/certs/gui_cert.pem` |
| This is the public certificate for Onezone service for securing the HTTPS traffic. |

| Web Server CA certificate |
|:-----------------|
| `/etc/oz_worker/cacerts/gui_cacert.pem` |
| This is the certificate of the CA authority used for signing Onezone certificates. |

## Oneprovider

| Web Server certificate |
|:-----------------|
| `/etc/op_worker/certs/onedataServerWeb.pem` |
|This certificate handles all HTTPS traffic for Web interface as well as REST and CDMI API's. The PEM file must contain the private key, public cert and trust chain all in a single file. |

| FUSE certificate |
|:-----------------|
| `/etc/op_worker/onedataServerFuse.pem` |
|This certificate handles communication between `onedata` command line client and the Oneprovider service. The PEM file must contain the private key, public cert and trust chain all in a single file. |

| FUSE certificate |
|:-----------------|
| `/etc/cacerts/grpCA.pem` |
|This is the root CA certificate of the Certification Authority used to sign FUSE certificates. |

## Onepanel

| Onezone and Oneprovider keys |
|:-----------------|
| `/var/lib/op_panel/certs/server.key` and `/var/lib/oz_panel/certs/server.key` |
| Keys used by Oneprovider and Onezone service respectively. |

| Onezone and Oneprovider certificates |
|:-----------------|
| `/var/lib/op_panel/certs/server.cert` and `/var/lib/oz_panel/certs/server.cert` |
| Keys used by Oneprovider and Onezone service respectively. |

## OpenID setup

In addition to configuration of X.509 certificates, there is also a need to configure properly the OpenID functionality.

This can be achieved by editing the `/var/lib/oz_worker/auth.config` file on Onezone node. Example file is presented below. All unnecessary login methods can be removed and all tokens must be replaced with actual application tokens and secrets for each service:

```Erlang
%% EXAMPLE auth.config - it is unusable without app IDs and secrets filled out.

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
    ]}
].
```


