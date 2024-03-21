# OIDC — Google IdP tutorial

Tutorial for configuring a Google OpenID Connect client, required to enable
the [login method][] with a Google account.

## Prerequisites

* An already deployed Onezone instance — see [here][1] for instructions.
* Access to a Google account.

## Procedure

1. Login to Google [https://accounts.google.com][2].

2. Open [https://search.google.com/search-console][3] and add the Onezone service domain.
   You will find the link in the left upper corner.

3. Copy and save the Google verification token.

4. Place a static DNS TXT record with the token in the `overlay.config`. For a
   `docker-compose` deployment, you will find it at `data/persistence/configs/overlay.config`:

    <!-- @TODO VFS-11766 link to onezone config management, mention init.d above -->

   ```
   [
       {oz_worker, [
           % preexisting entries ...

           {dns_static_txt_records, [
               {<<>>, <<"google-site-verification=abcdefgh123456789QWERTYUIASDFG-ZXCVBNqwerty">>}
           ]}
       ]}
   ].
   ```

    <!-- @TODO VFS-11766 below note can be covered inside the config docs-->

   ::: warning NOTE
   Make sure the config file is mounted in the Onezone container.
   :::

5. Restart Onezone for the new config to be picked up.

6. When Onezone is ready, click **Verify** in the Google UI.

7. Open [https://console.developers.google.com][4]

8. Create a new project or switch to an existing one.

9. Add your domain: **API → domain verification → add domain → enter domain → add domain**.

10. Configure the consent screen:
    **API- → OAuth consent screen → external → create → fill(application name, logo, email, authorized domain) → Save**.

11. Create credentials:
    **API → Credentials → CREATE CREDENTIALS → OAuth Client ID → Web Application →**
    **fill(name: "onedata", Authorized JavaScript origins: `https://example.com`,**
    **Authorized redirect URIs: `https://example.com/validate_login`) → Create.**

12. Place the credentials (client ID and secret) in `auth.config` (see [here][5] for more
    datails). For example:

    ```erlang
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
                        clientId => "123-qwertyuiopasdfghjkl1234567890zxc.apps.googleusercontent.com",
                        clientSecret => "ZXCVBNMasdfghjkl1234567-",
                        endpoints => #{
                            xrds => "https://accounts.google.com/.well-known/openid-configuration"
                        }
                    }
                }
            }},
    ```

13. Restart Onezone.

    ```
    $ sudo systemctl restart onezone
    ```

<!-- references -->

[login method]: ./oidc-saml.md

[1]: ../quickstart.md

[2]: https://accounts.google.com/

[3]: https://search.google.com/search-console/

[4]: https://console.developers.google.com.

[5]: ./oidc-saml.md#config-file-structure
