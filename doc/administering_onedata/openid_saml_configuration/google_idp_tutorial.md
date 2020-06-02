# Onezone Google IdP tutorial

<!-- toc -->

## Prerequisites
* Already deployed onezone instance is required for this tutorial. See [here](../onezone_quick_tutorial.md) if onezone is not installed yet.
* Access to a google account.

## Procedure

1. Login to Google https://accounts.google.com/
2. Open https://search.google.com/search-console/ and add the onezone
    service domain. You will find the link at the left upper corner. 
2. Copy and save the google verification token.
3. Place a static dns txt record with the token. Insert it in data/persistence/configs/overlay.config, e.g.:
```
[
    {oz_worker, [
        {external_ip, "1.2.3.4"},
        {enable_global_groups, true},
        {dns_static_txt_records, [
             {<<>>, <<"google-site-verification=abcdefgh123456789QWERTYUIASDFG-ZXCVBNqwerty">>}
        ]}
    ]}
].
```
  and restart onezone.
4. When onezone gets up click Verify.
5. Open https://console.developers.google.com.
6. Create a new project or switch to existing.
7. Add your domain: API->domain verification->add domain->enter domain->add domain
8. Configure consent screen: API-->oauth consent screen->external->create->fill(application name, logo, email, authorized domain)->Save.
9. Create credentials: API->Credentials->CREATE CREDENTIALS->OAuth Client ID->Web Application->fill(name: "onedata", Authorized JavaScript origins: `https://example.com`, Authorized redirect URIs: `https://example.com/validate_login`)->Create.
10. Place the credentials (client id and secret) in auth.conf. For example:
```
...
        {google, #{
            % Configuration of the login page button
            displayName => "Google",
            iconPath => "/assets/images/auth-providers/google.svg",
            iconBackgroundColor => "#F1514F",

            % Which protocol is used for this IdP
            protocol => openid,
            % Configuration specific for OpenID protocol - overrides the default
            protocolConfig => #{
                plugin => default_oidc_plugin,
                pluginConfig => #{
                    clientId => "1234567890123-qwertyuiopasdfghjkl1234567890zxc.apps.googleusercontent.com",
                    clientSecret => "ZXCVBNMasdfghjkl1234567-",
                    endpoints => #{
                        xrds => "https://accounts.google.com/.well-known/openid-configuration"
                    }
                }
            }
        }},
...
```
11. Restart onezone.
```
$ sudo systemctl restart onezone
```