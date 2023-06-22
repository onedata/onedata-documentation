# OIDC/SAML
**Config version 3**

<!-- @TODO VFS-7218 missing chapter -->

This documentation is valid for Onezone versions `19.02.*` or newer. 

OpenID and SAML are the main authentication methods used in Onedata. 
They allow users to reuse their accounts from other websites such as social 
networks or infrastructure portals.

When configuring Onedata, it is necessary to decide which Identity Providers
should be supported by the Onezone service. This can be achieved by editing 
the `/etc/oz_worker/auth.config` file on the Onezone node. In docker-compose 
based deployments, the most straightforward method is to mount the `auth.config`
file in the volumes section. 

> NOTE: the `auth.config` file must be present on all cluster nodes hosting the
Onezone worker service, and must be identical.

## Quickstart

By default, Onezone is packaged with config that enables only basic
authentication, placed in `/etc/oz_worker/auth.config`. After deploying Onezone,
a default user `admin` will be created, with password equal to the emergency 
passphrase provided in Onepanel during deployment - this way you can log in to a 
fresh Onezone installation without further setup.

> NOTE that deployment examples using docker-compose overwrite the `auth.config`
file with a mount from host. Simply remove this mount to use the default config 
(especially when you are not sure how to fill it out, because mounting an 
incorrect config will disable all login methods). 
[Here](#minimal-config) is the minimal `auth.config` that is installed by default.

You can follow this [tutorial](./google_idp_tutorial.md) in case the Google IdP will be used.

### Automatic config upgrade

During the first startup after upgrading Onezone to a newer version, Onezone will 
attempt to automatically upgrade the config file to the latest version. 
In such case, the old config file (`auth.config`) will be backed up to 
`auth.config.v{vsn}.bak`. Information whether the upgrade was successful will be 
present in [Onezone logs](./onezone_tutorial.md#logs). Always examine the 
upgraded `auth.config` file to make sure that it was correctly converted.

## Prerequisites 

To integrate with an OpenID or SAML Identity Provider, you need to have 
a basic knowledge of those protocols and interact with the Identity Providers to 
obtain all required information, register your services etc. In general, the
necessary steps are:


### OpenID Connect

1. Make sure your Onezone service is up and running on your domain, let it be
`onezone.example.com` for the sake of this example.

2. Visit the official documentation or website of the Identity Provider you 
want to integrate with. Explore their resources to find the specific process 
of integration, as it can vary for each Identity Provider. The integration process 
may involve an automatic setup through an online form or control panel, or it might 
require contacting the administrators for further assistance. Follow the provided 
instructions to proceed with the integration.

3. You will have to register your OpenID Connect client (Onezone), providing 
information such as domain, service name etc. When asked for 
*Redirection Endpoint (URL)*, specify the following:
```Erlang
https://onezone.example.com/validate_login
```

4. After finishing the registration process, you will be issued a Client Id and 
Client Secret.

5. In the [supported IdPs list](#supported-idps), create a new element by choosing 
a unique identifier (e.g. `google`). Fill out all the required information, including
the Client Id and Secret associated with the chosen Identity Provider. The `protocol` 
attribute must be set to `openid`.

6. Depending on the IdP, there might be more configuration options regarding the
OpenID flow - some of them are reflected in the [pluginConfig](#openid-example).

7. Put the `auth.config` on the Onezone host under `/etc/oz_worker/auth.config` 
and wait for up to a minute (default config caching time), or restart the 
Onezone service for immediate effect.

8. You should see your IdP on the [login page](#the-login-page), verify that it 
works correctly by clicking on its icon to go through the login process. In case 
of any errors, examine [Onezone logs](../onezone_tutorial.md#logs).

9. At any time, you can use the [test login page](#test-login-page) to test your 
auth.config without interrupting the Onezone service.

### SAML

1. Make sure your Onezone service is up and running on your domain, let it be
`onezone.example.com` for the sake of this example.

2. Generate a strong RSA x509 key pair (can be self signed) and put them on your
Onezone host - a tutorial can be found 
[here](https://www.switch.ch/aai/support/certificates/embeddedcerts-requirements-appendix-a/)

3. Decide on your SAML Entity Id which is typically constructed using your domain, 
e.g. `https://onezone.example.com/sp`. It does not have to point to an existing resource, 

4. Fill out the [SAML Config](#saml-config) section of the `auth.config`, 
putting down all the required information, including the Entity Id and paths
to the key and cert.

5. Put the `auth.config` on the Onezone host under `/etc/oz_worker/auth.config` 
and wait for up to a minute (default config caching time), or restart the 
Onezone service for immediate effect.

6. Visit `https://onezone.example.com/saml/sp.xml` and verify that the advertised
metadata is correct. In case of any errors, examine 
[Onezone logs](../onezone_tutorial.md#logs).

7. Visit the official website of the Identity Provider or organization (e.g. eduGAIN)
you want to integrate with. Explore their resources to find the specific process 
of integration, as it can vary for each Identity Provider. The integration process 
may involve an automatic setup through an online form or control panel, or it might 
require contacting the administrators for further assistance. Follow the provided 
instructions to proceed with the integration.

8. Register your SAML Service Provider (Onezone). During the process, you will 
most probably be required to provide the URL to the SAML SP Metadata (pt. 6), or 
provide a static XML with the metadata (which can be simply downloaded from this 
endpoint).

9. Create a new element in the [supported IdPs list](#supported-idps), choosing 
a unique identifier (e.g. `elixir`), and fill out all the information. The 
`protocol` attribute must be set to `saml`.

10. Reload the `auth.config` again (pt. 5).

11. You should see your IdP on the [login page](#the-login-page), verify that it 
works correctly by clicking on its icon to go through the login process. In case 
of any errors, examine [Onezone logs](../onezone_tutorial.md#logs).

12. At any time, you can use the [test login page](#test-login-page) to test your 
auth.config without interrupting the Onezone service.


### The login page

After adding your IdPs to the config file, you should see corresponding icons on
the login page (`https://onezone.example.com`). If there are more than 7 IdPs,
the first 6 will be shown and the rest hidden in the `...` button.

<img style="display:block;margin:0 auto;"
src="../../../../images/admin-guide/onezone/configuration/oidc-saml/login-page.png#screenshot">
<!-- FIXME - replace with actual one -->


## Config file structure

This section presents and discusses an exemplary `auth.config`, section by 
section. The whole file is presented at the end. A template ready to fill out 
can be found in `/etc/oz_worker/template.auth.config` or 
[at the end of this section](#complete-example).


### General remarks

The `auth.config` file is written in Erlang format, quite similar to JSON:

* `#{Key1 => Value1, Key2 => Value2}` is a key-value map (can be nested)
* `[ ... ]` is a list 
* `{A, B}` is a two value tuple
* `undefined` is a special `atom` indicating that given parameter is not 
specified (`null`)
* `"some text"` is a string
* `% ...` is a comment
* `true` or `false` is a boolean


### Main sections

The config file has the following sections:

```Erlang
#{
    version => 3,

    % Allows to log in to Onezone using username & password.
    basicAuthConfig => #{
        enabled => true
    },

    openidConfig => #{
        ...
    },

    samlConfig => #{
        ...
    },

    supportedIdps => [
        ...
    ]
}
        
```

`version` - obligatory field that defines the version of the config file,
currently the newest is `3`. If no version field is found, version `1` is
assumed. Used by Onezone to determine if an upgrade is required.

### basicAuth Config

`basicAuthConfig` - this section enables or disables basicAuth - the possibility 
to log in to Onezone using username & password. This also controls the 
possibility to authorize Onezone REST API operations using basic credentials.

> Note that to allow for login via Onezone GUI, `basicAuth` must be enabled,
and present on the list of supported IdPs ([see below](#supported-idps)).

> Default "admin" user is always created during installation process. Additional
users can be created [using the API](../creating_user_accounts.md).

### OpenID config

`openidConfig` - this section contains common OpenID configuration and defaults
that will be inherited by all OpenID IdPs. Please examine this snippet from the
`/etc/oz_worker/template.auth.config` to learn the meaning of certain attributes:

```Erlang
    openidConfig => #{
        % Enable OpenID login protocol - if disabled, all OpenID IdPs will be
        % hidden from the login page.
        enabled => true,
        % Default config for every OpenID IdP, can be overridden in IdP config
        defaultProtocolConfig => #{
            % Internal plugin that will be used for handling the login process -
            % if the IdP uses standard OpenID Connect protocol,
            % default_oidc_plugin is the way to go. If not, IdP specific plugin
            % can be implemented and specified here.
            plugin => default_oidc_plugin,
            % Config specific for default_oidc_plugin
            pluginConfig => #{
                % Scope requested from OpenID Connect IdP
                scope => "openid email profile",
                % HTTP method used to exchange auth code for an access token: post | get
                accessTokenAcquireMethod => post,
                % How the client secret should be sent to the IdP: urlencoded | inAuthHeader
                clientSecretPassMethod => urlencoded,
                % How user's access token should be sent to the IdP: urlencoded | inAuthHeader
                accessTokenPassMethod => inAuthHeader,
                % Allows to augment requests with additional data
                customData => #{
                    % Additional data for access_token endpoint request
                    accessToken => #{
                        % query string or post body parameters (key-value)
                        parameters => undefined,
                        % headers (key-value)
                        headers => undefined
                    },
                    % Additional data for userinfo endpoint request
                    userInfo => #{
                        parameters => undefined,
                        headers => undefined
                    }
                }
            },
            % Enables/disables authorization using access tokens from the IdP
            % Supported only in OpenID protocol
            authorityDelegation => #{
                % Enabled for this IdP
                enabled => true
                % The tokenPrefix attribute defines a prefix used to distinguish
                % tokens from given IdP. It defaults to "<idp>:", where <idp> is
                % the identifier used in config. Can be overriden in IdP config,
                % like the following:
                %       tokenPrefix => "my-idp/"
                % Exemplary token usage with with such config:
                % curl -H "X-Auth-Token: my-idp/lkj9s87rf1234SDfh6721hqd7991" ...
            },
            % If enabled, Onezone will ask for refresh tokens and store them so
            % that it is later possible to acquire user's access token issued by 
            % given IdP without him being logged in. Only OIDC IdPs are supported.
            offlineAccess => true,
            % Defines how the attributes from OpenID user info should be mapped
            % to Onedata user attributes. Attributes must correspond to existing
            % OpenID attributes.
            attributeMapping => #{
                subjectId => {required, "sub"},
                fullName => {required, {any, ["name", "fullName"]}},
                username => {optional, "username"},
                emails => {optional, "email"},
                entitlements => {optional, "groups"},
                custom => {optional, "name"}
            },
            % Rules for mapping entitlements in the IdP into entitlements in Onedata.
            entitlementMapping => #{
                enabled => false
            }
        }
    },

```

More details:

* `plugin` - specifies the Erlang module that handles the login process. If not 
specified, it defaults to `default_oidc_plugin`, which can handle most of
standard OpenID Connect IdPs. It is possible to implement your own, specialized 
plugin - see more in [Auth plugins](#auth-plugins). Currently, Onezone supports
one OpenID 1.0 IdP - the PLGrid organization that uses `plgrid_openid_plugin` - 
see [this example](#plgrid-config-openid-20). 

* `pluginConfig` - config specific for the `default_oidc_plugin`, 
[see below](#openid-example)

* `authorityDelegation` - [see below](#authority-delegation)

* `offlineAccess` - [see below](#offline-access)

* `attributeMapping` - [see below](#attribute-mapping)

* `entitlementMapping` - [see below](#entitlement-mapping)


### SAML config

`samlConfig` - similarly to `openidConfig`, this section contains common SAML
configuration and defaults that will be inherited by all SAML IdPs. 
Please examine this snippet from the `/etc/oz_worker/template.auth.config`:

```Erlang
    samlConfig => #{
        % Enable SAML login protocol - if disabled, all SAML IdPs will be hidden
        % from the login page and the endpoint serving SAML metadata will be
        % disabled.
        enabled => true,
        % Information used to build SAML SP metadata XML, refer to SAML
        % documentation for details on below attributes.
        spConfig => #{
            entityId => "https://onezone.example.com/sp",
            certFile => "/etc/oz_worker/certs/saml_cert.pem",
            keyFile => "/etc/oz_worker/certs/saml_key.pem",
            organizationName => "My organization",
            organizationDisplayName => "My organization",
            techContactName => "John Doe",
            techContactEmail => "john.doe@onezone.example.com",
            % Should the metadata be signed with keyFile
            signMetadata => false,
            % Should the Auth Requests be signed with keyFile
            signRequests => true,
            % Should Onezone request signed assertions
            wantAssertionsSigned => true
        },
        % Default config for every SAML IdP, can be overridden in IdP config
        defaultProtocolConfig => #{
            % SSO binding - defines what type of request should be performed
            % to redirect the user to the IdP's login page. Possible values:
            % http_redirect (default) or http_post
            preferredSsoBinding => http_redirect,
            % Defines how the attributes from SAML user info should be mapped
            % to Onedata user attributes. Attributes must correspond to existing
            % SAML attributes.
            attributeMapping => #{
                subjectId => {required, "eduPersonTargetedID"},
                fullName => {required, {any, ["displayName", "surName"]}},
                username => {optional, "eduPersonPrincipalName"},
                emails => {optional, "mail"},
                entitlements => {optional, "eduPersonEntitlement"},
                custom => {optional, "eduPersonScopedAffiliation"}
            },
            % Rules for mapping entitlements in IdP into entitlements in Onedata.
            entitlementMapping => #{
                % Enable / disable entitlement mapping for given IdP
                enabled => true,
                % The name of the parent group to which all groups from this IdP
                % will belong (reflecting a Virtual Organization)
                voGroupName => undefined,
                % A special group that has admin rights to all groups from this
                % IdP.
                adminGroup => undefined,
                % Erlang module (plugin) that will be used to parse user's
                % entitlements from this IdP
                parser => nested_entitlement_parser,
                % Config specific for the nested_entitlement_parser
                parserConfig => #{
                    splitWith => "/",
                    topGroupType => unit,
                    topGroupPrivilegesInVo => member,
                    subGroupsType => team,
                    subGroupsPrivilegesInParent => member,
                    userPrivileges => member
                }
            }
        }
    },
```

More details:

* `spConfig` - information put here will be used to build the SAML 
Service Provider XML, which will be advertised under 
`https://onezone.example.com/saml/sp.xml`. Remember that paths provided in 
key / cert field must point to existing files, otherwise the XML will not be 
generated. Refer to SAML documentation for details on certain fields. 

* `attributeMapping` - [see below](#attribute-mapping)

* `entitlementMapping` - [see below](#entitlement-mapping)


### Supported IdPs

This section provides a list of all Identity Providers (IdPs) that
will be available for selection on the login page. The order of the
buttons on the login page corresponds to the order of the entries in
this section. The general structure of this section is as follows:

```Erlang
    supportedIdps => [
        % IdP identifier, must be a unique, arbitrary atom
        {myIdP, #{
            % Configuration of the login page button
            displayName => "My IdP",
            % Some predefined icons are built-in into the GUI app.
            % Their paths start with /assets/images/auth-providers.
            % For a custom icon, put it in:
            %   /var/www/html/oz_worker/custom/<path>
            % And reference it here like this: /custom/<path>
            iconPath => "/assets/images/auth-providers/default.svg",
            % Background color is useful for icons with transparency. Moreover,
            % after selecting an IdP, its icon disappears and a spinner is 
            % shown - hence background color should be kept the same as icon's 
            % background color (if any) for better visual effect.
            iconBackgroundColor => "#4BD187",
    
            % Which protocol is used for this IdP
            protocol => openid,
            % Config specific for given protocol
            protocolConfig => #{
                ...
            }
        }},
        
        {anotherIdP, #{
            ...
        }},
        
        ...
    ]
```

More details:

* *IdP identifier* (`myIdP` in this example) - must be unique across the 
`auth.config` file and be an Erlang atom (basically starting with a lowercase 
letter and containing only letters or underscores; refer to Erlang documentation 
for more). 
> Note that the identifier *basicAuth* is reserved for 
[basicAuth](#basicauth-example) and *more* is reserved for 
internal purposes and cannot be used.

* `iconPath` - path to the static image file that will be used for the IdP icon 
on the login page. Some predefined icons are available under the path
`/assets/images/auth-providers/<icon>.svg`, to see the full list visit the 
[Onezone GUI repo](https://github.com/onedata/onezone-gui/tree/develop/src/public/assets/images/auth-providers).
To learn how you can add your own icons to the login page, see 
[custom icon guidelines](#custom-icon-guidelines). If not specified, `iconPath` 
defaults to `/assets/images/auth-providers/default.svg`.

* `protocol` - one of `basicAuth`, `saml`, `openid`.

* `protocolConfig` - depends on the protocol, see the following sections for 
config examples for each protocol.

> Note that if you disable any protocol in the `basicAuthConfig`,
`openidConfig`, or `samlConfig` sections, it will result in the
disabling of all Identity Providers (IdPs) that use that particular
protocol. Consequently, those disabled IdPs will be hidden from the
login screen.

#### basicAuth example

```Erlang
        % basicAuth is a special IdP id reserved for signing in with username & password 
        % and the only valid config entry using the basicAuth protocol.
        {basicAuth, #{
            % Configuration of the login page button
            displayName => "username & password",
            % Some predefined icons are built-in into the GUI app.
            % Their paths start with /assets/images/auth-providers.
            % For a custom icon, put it in:
            %   /var/www/html/oz_worker/custom/<path>
            % And reference it here like this: /custom/<path>
            iconPath => "/assets/images/auth-providers/basicauth.svg",
            % Background color is useful for icons with transparency. Moreover,
            % after selecting an IdP, its icon disappears and a spinner is
            % shown - hence background color should be kept the same as icon's
            % background color (if any).
            iconBackgroundColor => "#4BD187",

            % Which protocol is used for this IdP - basicAuth is the only
            % valid one for basicAuth IdP.
            protocol => basicAuth
        }},
```


#### OpenID example

```Erlang
        {google, #{
            % Configuration of the login page button
            displayName => "Google",
            % Some predefined icons are built-in into the GUI app.
            % Their paths start with /assets/images/auth-providers.
            % For a custom icon, put it in:
            %   /var/www/html/oz_worker/custom/<path>
            % And reference it here like this: /custom/<path>
            iconPath => "/assets/images/auth-providers/google.svg",
            % Background color is useful for icons with transparency. Moreover,
            % after selecting an IdP, its icon disappears and a spinner is
            % shown - hence background color should be kept the same as icon's
            % background color (if any).
            iconBackgroundColor => "#F1514F",

            % Which protocol is used for this IdP
            protocol => openid,
            % Configuration specific for OpenID protocol - overrides the default
            protocolConfig => #{
                % Internal plugin that will be used for handling the login process -
                % if the IdP uses standard OpenID Connect protocol,
                % default_oidc_plugin is the way to go. If not, IdP specific plugin
                % can be implemented and specified here.
                plugin => default_oidc_plugin,
                % Config specific for default_oidc_plugin
                pluginConfig => #{
                    % Client Id and secret acquired during registration
                    clientId => "****************************************************",
                    clientSecret => "****************************************************",
                    % Defines how to resolve OpenID endpoints
                    endpoints => #{
                        % The XRDS endpoint, will be used if referenced in below endpoints
                        xrds => "https://accounts.google.com/.well-known/openid-configuration",
                        % standard OIDC endpoints - literal URLs or tuples {xrds, "key"} -
                        % "key" will be extracted from the XRDS JSON.
                        authorize => {xrds, "authorization_endpoint"},
                        accessToken => {xrds, "token_endpoint"},
                        userInfo => {xrds, "userinfo_endpoint"}
                    },
                    % Scope requested from OpenID Connect IdP
                    scope => "openid email profile",
                    % HTTP method used to exchange auth code for an access token: post | get
                    accessTokenAcquireMethod => post,
                    % How the client secret should be sent to the IdP: urlencoded | inAuthHeader
                    clientSecretPassMethod => urlencoded,
                    % How user's access token should be sent to the IdP: urlencoded | inAuthHeader
                    accessTokenPassMethod => inAuthHeader,
                    % Allows to augment requests with additional data
                    customData => #{
                        % Additional data for access_token endpoint request
                        accessToken => #{
                            % query string or post body parameters (key-value)
                            parameters => #{"param1" => "val1"},
                            % headers (key-value)
                            headers => #{"header1" => "val1"}
                        },
                        % Additional data for userinfo endpoint request
                        userInfo => #{
                            parameters => #{"param2" => "val2"},
                            headers => #{"header2" => "val2"}
                        }
                    }
                },

                % Enables/disables authorization using access tokens from the IdP
                % Supported only in OpenID protocol
                authorityDelegation => #{
                    % Enabled for this IdP
                    enabled => true,
                    % The tokenPrefix attribute defines a prefix used to distinguish
                    % tokens from given IdP.
                    % Exemplary token usage with the below such config:
                    % curl -H "X-Auth-Token: google:lkj9s87rf1234SDfh6721hqd7991" ...
                    tokenPrefix => "google:"
                },
                % If enabled, Onezone will ask for refresh tokens and store them so
                % that it is later possible to acquire user's access token issued by 
                % given IdP without him being logged in. Only OIDC IdPs are supported.
                offlineAccess => true,
                % Defines how the attributes from OpenID user info should be mapped
                % to Onedata user attributes. Attributes must correspond to existing
                % OpenID attributes.
                attributeMapping => #{
                    subjectId => {required, "sub"},
                    fullName => {required, {any, ["name", "fullName"]}},
                    username => {optional, "username"},
                    emails => {optional, "email"},
                    entitlements => {optional, "given_name"},
                    custom => {optional, "given_name"}
                },
                % Rules for mapping entitlements in the IdP into entitlements in Onedata.
                entitlementMapping => #{
                    enabled => true,
                    % The name of the parent group to which all groups from this IdP
                    % will belong (reflecting a Virtual Organization)
                    voGroupName => undefined,
                    % A special group that has admin rights to all groups from this
                    % IdP.
                    adminGroup => undefined,
                    parser => flat_entitlement_parser,
                    parserConfig => #{
                        groupType => team,
                        groupPrivilegesInVo => member,
                        userPrivileges => member
                    }
                }
            }
        }},
```

This IdP will inherit all configuration from 
`openidConfig -> defaultProtocolConfig`, apart from the parameters that are
overriden here. 
> Note: to nullify a parameter specified in the default config, it must be
explicitly set to `undefined` in IdP config - otherwise it will be inherited.

More details on `pluginConfig`:

* `endpoints` - this section defines how to resolve standard OpenID
endpoints (`authorize`, `accessToken`, `userInfo`). Most IdPs use an
XRDS endpoint to serve a JSON containing all required URLs. To utilize
the XRDS, simply specify the `xrds` field and reference the desired
keys from the JSON, as demonstrated in the example above.
Alternatively, you can directly enter the URLs, eliminating the need
for an XRDS endpoint.  The `userInfo` endpoint is a special case that
allows you to specify multiple endpoints. Information gathered from
them will be aggregated. Consider the following example, which
demonstrates the use of direct URLs and multiple userInfo endpoints:
```Erlang
endpoints => #{
    authorize => "https://github.com/login/oauth/authorize",
    accessToken => "https://github.com/login/oauth/access_token",
    userInfo => [
        "https://api.github.com/user",
        {"emails", "https://api.github.com/user/emails"}
    ]
},
```
In the above example, JSON collected from `"https://api.github.com/user"` will
be appended as-is to user attributes, and the JSON from 
`"https://api.github.com/user/emails"` will be inserted under the key `"emails"`.

* `scope` - what attributes are requested from the IdP. Defaults to 
`"openid email profile"`.

* `accessTokenAcquireMethod` - `get` or `post`, defines the HTTP method used
to exchange auth code for an access token. Defaults to `post`.

* `clientSecretPassMethod` - `urlencoded` or `inAuthHeader`, defines how the
Client Id and Secret should be sent to the IdP's access token endpoint. 
Defaults to `urlencoded`.

* `accessTokenPassMethod` - `urlencoded` or `inAuthHeader`, defines how the
Access Token should be sent to the IdP's userinfo endpoint. 
Defaults to `urlencoded`.

* `customData` - allows to augment requests to the IdP with arbitrary data,
appended to the request data (query string or post body) or headers. Can be
specified for `accessToken` or `userInfo` endpoints.

Refer to the IdP's documentation to find out what should be inserted in the
attributes: `endpoints`, `scope`, `accessTokenAcquireMethod`, 
`clientSecretPassMethod`, `accessTokenPassMethod`, `customData`. 
Note that some of them can be configurable on the IdP side too.


#### SAML example

```Erlang
        {elixir, #{
            % Configuration of the login page button
            displayName => "Elixir",
            % To use the icon like below, put it in:
            
            %   /var/www/html/oz_worker/custom/images/elixir.svg
            iconPath => "/custom/images/elixir.svg",
            % Background color is useful for icons with transparency. Moreover,
            % after selecting an IdP, its icon disappears and a spinner is
            % shown - hence background color should be kept the same as icon's
            % background color (if any).
            iconBackgroundColor => "#FF7A04",

            % Which protocol is used for this IdP
            protocol => saml,
            % Configuration specific for SAML protocol - overrides the default
            protocolConfig => #{
                % URL pointing to IdP SAML metadata XML
                metadataUrl => "https://login.elixir-czech.org/proxy/saml2/idp/metadata.php",
                % SSO binding - defines what type of request should be performed
                % to redirect the user to the IdP's login page. Possible values:
                % http_redirect (default) or http_post
                preferredSsoBinding => http_redirect,
                % Defines how the attributes from SAML user info should be mapped
                % to Onedata user attributes. Attributes must correspond to existing
                % SAML attributes.
                attributeMapping => #{
                    subjectId => {required, "eduPersonUniqueId"},
                    fullName => {required, "displayName"},
                    username => {optional, "eduPersonPrincipalName"},
                    emails => {optional, "mail"},
                    entitlements => {optional, "eduPersonEntitlement"},
                    custom => {optional, "eduPersonScopedAffiliation"}
                },
                % Rules for mapping entitlements in IdP into entitlements in Onedata.
                entitlementMapping => #{
                    % Enable / disable entitlement mapping for given IdP
                    enabled => true,
                    % The name of the parent group to which all groups from this IdP
                    % will belong (reflecting a Virtual Organization)
                    voGroupName => "Elixir",
                    % A special group that has admin rights to all groups from this
                    % IdP.
                    adminGroup => "elixir_test:tsi-admin",
                    % Erlang module (plugin) that will be used to parse user's
                    % entitlements from this IdP
                    parser => nested_entitlement_parser,
                    % Config specific for the nested_entitlement_parser
                    parserConfig => #{
                        splitWith => ":",
                        topGroupType => unit,
                        topGroupPrivilegesInVo => member,
                        subGroupsType => team,
                        subGroupsPrivilegesInParent => member,
                        userPrivileges => member
                    }
                }
            }
        }}
    ]
```

This IdP will inherit all configuration from 
`samlConfig -> defaultProtocolConfig`, apart from the parameters that are
overriden here. 
> Note: to nullify a parameter specified in default config, it must be
explicitly set to undefined in IdP config - otherwise it will be inherited.

Unlike `openid`, SAML IdPs do not have pluginable handlers and hence there is
no `plugin` or `pluginConfig` section (all config is expressed on the 
`procotolConfig` level).


#### OpenID & SAML similarities

Note that the following sections in `protocolConfig` of `openid` and `saml` 
protocols are syntactically and functionally the same:

* `attributeMapping` - [see below](#attribute-mapping)

* `entitlementMapping` - [see below](#entitlement-mapping)

However, only the `openid` protocol supports 
[authorityDelegation](#authority-delegation) and [offlineAccess](#offline-access).


### Authority Delegation

Onezone service supports authority delegation using other OpenID connect
providers. When enabled, it allows users to directly use their access tokens
(e.g. from GitHub) to authorize operations in Onezone.

In order to enable this feature for specific IdP, an `authorityDelegation` 
section has to be added to the IdP's protocol config, for instance:

```Erlang
authorityDelegation => #{
    % Enabled for this IdP
    enabled => true,
    % The tokenPrefix attribute defines a prefix used to distinguish
    % tokens from given IdP. It defaults to "<idp>:", where <idp> is
    % the IdP identifier used in config.
    tokenPrefix => "github/"
},
```

In such case, users can directly access the Onezone API using access tokens
obtained from the IdP by prefixing the access token and placing it in the 
`X-Auth-Token` or `Authorization: Bearer <token>` header:
```
X-Auth-Token: github/e72e16c7e42f292c6912e7710c838347ae178b4a
Authorization: Bearer github/e72e16c7e42f292c6912e7710c838347ae178b4a
```
where `e72e16c7e42f292c6912e7710c838347ae178b4a` is the actual GitHub access 
token.


### Offline access

Onezone service can act as a dispenser for access tokens issued by
IdPs that users are logging in with.  If offline access is enabled in
the configuration, Onezone will request refresh tokens and store
them. This enables the acquisition of a user's access token, issued by
a specific IdP, even if the user is not currently logged in.  Only
OIDC IdPs are supported. Offline access must be supported by the given
IdP for this to work. In order to enable this feature for specific
IdP, an `offlineAccess` field has to be added to the IdP's protocol
config, for instance:

```Erlang
offlineAccess => true,
```

> NOTE: Enabling `offlineAccess` will cause Onezone to add the 
`access_type=offline` parameter to OIDC authorization request. Some IdPs might
also require adding the `offline_access` scope, in which case you must add it
manually in the `scope` field of the plugin config. 

> NOTE: When combined with enabled authority delegation, it is
important to consider the security implications. With authority
delegation, every IdP actively used by a user will have the ability
to acquire the user's IdP access token. As a result, these IdPs will
be able to gain full authorization on behalf of the user.

IdP access tokens can be acquired using the Onezone 
[REST API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/acquire_idp_access_token).


### Attribute Mapping

Onezone collects information about users from SAML / OpenID, including:
* `subjectId` - user's unique, permanent id assigned by the IdP, mandatory
(login will fail if mapping cannot be found),

* `fullName` - given names and surname, e.g. "John Doe",

* `username` - a human-readable identifier, unique across the system, 
e.g. "johndoe13". This makes it easier to identify the user and can be used for 
signing in with password (if this sign-in method is enabled for given user),

* `emails` - a list of user's emails,

* `entitlements` - a list of user's entitlements to groups in the IdP, which
can later be mapped to groups in Onedata using 
[entitlement mapping](#entitlement-mapping),

* `custom` - arbitrary JSON received from the IdP, which can be useful
during later integration with storage systems ([LUMA](#luma-integration)).

These attributes constitute a linked account object. It can be expressed in JSON 
format:
```JSON
{
	"idp": "elixir",
	"subjectId": "1234567890@elixir-europe.org",
	"fullName": "John Doe",
	"username": "jodoe",
	"emails": ["john.doe@google.com"],
	"entitlements": ["group1", "group2"],
	"custom": {
		"organization": "My Organization",
		"roles": ["role1", "role2", "role3"]
	}
}
```
Attribute mapping is used to map attributes received from Identity Providers
into linked account objects in Onedata.


#### Merging linked accounts into Onedata user

Every user in Onedata can have one or more linked accounts. Upon the first
login, a new Onedata user is created based on information gathered from the IdP
that he logged in with:
```
userId: md5(<IdP>:<subjectId>)
fullName: <fullName>        % can be undefined
username: <username>        % can be undefined
emails: <emails>
linkedAccounts: [<linked-acc-json>]
```
From now on, `userId` in Onedata will not change (i.e. it is derived from the
`subjectId` in the first IdP the user has logged in with). `fullName` and
`username` will also be unchanged by consecutive log-ins, even if the IdP 
attributes change. `emails` are always a list of emails aggregated from all 
linked accounts.

> New accounts can be linked after logging in, in user profile menu. It is not
possible to link the same account to two different users.

Complete user data, after logging in with the above Elixir account, would look 
like the following:
```JSON
{
	"userId": "fa81af19783e3eea7d7e80c1d89f5370",
	"fullName": "John Doe",
	"username": "jodoe",
	"emails": ["john.doe@google.com"],
	"linkedAccounts": [{
        "idp": "elixir",
        "subjectId": "1234567890@elixir-europe.org",
        "fullName": "John Doe",
        "username": "jodoe",
        "emails": ["john.doe@google.com"],
        "entitlements": ["group1", "group2"],
        "custom": {
            "organization": "Elixir",
            "roles": ["role1", "role2", "role3"]
        }
    }]
}
```
Assume that user links another account, e.g. from Indigo, which yield the 
following linked account object:
```JSON
{
    "idp": "indigo",
	"subjectId": "12345678-1234-1234-1234-12345678",
	"fullName": "John Doe",
	"username": "john-doe",
	"emails": ["john.doe@yahoo.com"],
	"entitlements": ["Users", "Developers"],
	"custom": {
	    "gender": "M"
	}
}
```
After that operation, the complete user data would look like the following:
```JSON
{
	"userId": "fa81af19783e3eea7d7e80c1d89f5370",
	"fullName": "John Doe",
	"username": "jodoe",
	"emails": ["john.doe@google.com", "john.doe@yahoo.com"],
	"linkedAccounts": [{
        "idp": "elixir",
        "subjectId": "1234567890@elixir-europe.org",
        "fullName": "John Doe",
        "username": "jodoe",
        "emails": ["john.doe@google.com"],
        "entitlements": ["group1", "group2"],
        "custom": {
            "organization": "Elixir",
            "roles": ["role1", "role2", "role3"]
        }
    },{
        "idp": "indigo",
        "subjectId": "12345678-1234-1234-1234-12345678",
        "fullName": "John Doe",
        "username": "john-doe",
        "emails": ["john.doe@yahoo.com"],
        "entitlements": ["Users", "Developers"],
        "custom": {
            "gender": "M"
      	}
    }]
}
```
This user data constitutes input in [Local User Mapping](#luma-integration) - 
when mapping Onedata users into storage users within Oneprovider.

> User data can also be retrieved using the 
[REST API](/#/home/api/latest/onezone?anchor=operation/get_current_user).


#### Attribute mapping rules

Attribute mapping is performed based on the IdP configuration in  `auth.config`. 
The section looks like the following:
```Erlang
attributeMapping => #{
  subjectId => {required, <rule>},
  fullName => {optional, <rule>},
  username => undefined,
  emails => {optional, <rule>},
  entitlements => {plugin, my_entitlement_parser},
  custom => {required, <rule>}
}
```

Allowed mappings are:
* `undefined` - this attribute is not mapped at all, it is equivalent to 
deleting the attribute mapping completely from the config.

* `{required, <rule>}` - this attribute will be mapped according to `<rule>`, if 
it's not possible to resolve the attribute the login will fail.

* `{optional, <rule>}` - this attribute will be mapped according to `<rule>`, if 
it's not possible to resolve the attribute the mapped value will be empty 
(undefined).

* `{plugin, Module}` - allows to use arbitrary plugin to perform the mapping. 
`Module:map_attribute(Attr, IdPAttributes)` will be called and should return the 
resolved attribute value as `{ok, Value}`, or `{error, Reason}` if it could not 
be found. The IdPAttributes argument is an Erlang map (keys are binaries). The module must be 
placed in the auth [plugins directory](#auth-plugins). For more info, refer to 
[attribute mapper](#attribute-mapper). Here is an example:
```Erlang
fullName => {plugin, my_attr_mapper}
% would call my_attr_mapper:map_attribute(fullName, IdPAttributes)
```

`<rule>` can be a complex, nested term built from the following expressions:

* `"attrName"` - name of an attribute. If such key is present in attributes
received from IdP, the rule is expanded to its value. Here is an example:
```Erlang
id => {required, "id"}
emails => {optional, "mail"}
```

* `{keyValue, "attrName"}` - similar to the "attrName" rule, but the result
will contain both the attribute key and value as a JSON object. Here is an example:
```Erlang
custom => {optional, {keyValue, "schacHomeOrganization"}}
% would set user's custom value to
{"custom": {"schacHomeOrganization": "orgName"}}
% instead of just
{"custom": "orgName"}
```

* `{keyValue, "keyName", <rule>}` - similar to the `{keyValue, "attrName"}`, but
`<rule>` can expand to any value and the key in result JSON can be specified 
explicitly. Here is an example:
```Erlang
custom => {optional, {keyValue, "organization", "schacHomeOrganization"}}
% would set user's custom value to:
{"custom": {"organization": "orgName"}}
```

* `{str, "literal"}` - the rule will be expanded to the literal string. Here is an example:
```Erlang
fullName => {required, {str, "John Doe"}}
% would make all users have the same fullName; `"John Doe"
```

* `{str_list, ["str1", "str2"]}` - the rule will be expanded to a list of
literal strings. Here is an example:
```Erlang
entitlements => {required, {str_list, ["group1", "group2, "group3"]}}
% would make all users have the same three entitlements
```

* `{nested, ["key1", "key2", {list, "key3"}]}` - the rule will be expanded to a 
value nested in a JSON. The special expression `{list, key}` can be used to parse a
list of JSON objects, where each object has a specific key. Here is an example:
```Erlang
emails => {nested, ["emails", {list, "email"}]}
% would parse the following JSON:
{"emails": [
    {"email": "abc@example.com", "verified": true},
    {"email": "def@example.com", "verified": false}
]}
% into the following list of emails:
["abc@example.com", "def@example.com"]
```

* `{replace, "regex", "replacement", <rule>}` - this rule replaces matching
substrings with the specified replacement. `<rule>` can expand to a string or a
list of strings, in which case the operation will be repeated on each
string. The replacement operation utilizes Erlang's `re:replace/4` function, so
the regular expressions and replacements must be constructed according to
Erlang's regex format, which differs slightly from other formats. Here is an
example:

```Erlang
fullName => {replace, "(.*) (.*) (.*)", "\\1 \\3", "fullName"}
% would change all 3-part names to 2-part, leaving out the middle one 
% (e.g. John II Doe -> John Doe). Unmatched strings are not modified.
```

* `{concat, [<ruleA>, <ruleB>, ...]}` - concatenates a list of strings into one
string, one by one: `((<ruleA> + <ruleB>) + <ruleC>) + <ruleD> ...`. 
Every `<rule>` must expand to a string or a list of strings. If a single string 
is concatenated with a list, it is concatenated with every element of the list. 
If two lists are concatenated, the elements are concatenated in pairs, creating 
a new list. If any of the lists is shorter, it is padded with empty strings. 
Examine possible combinations:
```Erlang
{concat, []} ->
    undefined
{concat, [{str, "a"}]} ->
    "a"
{concat, [{str, "a"}, {str, "b"}]} ->
    "ab"
{concat, [{str, "a"}, {str_list, ["1", "2", "3"]}]} -> 
    ["a1", "a2", "a3"]
{concat, [{str_list, ["a", "b", "c"]}, {str, "1"}]} -> 
    ["a1", "b1", "c1"]
{concat, [{str_list, ["a", "b", "c"]}, {str_list, ["1", "2", "3"]}]} -> 
    ["a1", "b2", "c3"]
{concat, [{str_list, ["a", "b", "c", "d"]}, {str_list, ["1", "2"]}]} -> 
    ["a1", "b2", "c", "d"]
```
Example:
```Erlang
{entitlements => {concat, [{str, "group:"}, "groups"]}
% would prefix every user's entitlement with "group:"
```

* `{join, "joinWith", <rule>}` - joins a list of strings with given string.
`<rule>` must expand to a list of strings, or a single string (in which case 
the join just return the string unchanged). Here is an example:
```Erlang
{join, " ", "nameTokens"}
% would parse the following JSON:
{"nameTokens": ["John", "Doe", "Junior"]}
% into the following fullName:
"John Doe Junior"
```

* `{split, "splitWith", <rule>}` - splits a string into a list of strings on
given "splitWith" string. `<rule>` must expand to a string, or a list of strings 
in which case the results of splitting every string will be appended in one 
result list. Here is an example:
```Erlang
{entitlements => {optional, {split, ",", "groups"}}
% would parse the following JSON:
{"groups": "group1,team2,role3"}
% into the following list of entitlements:
["group1", "team2", "role3"]
% or the following JSON:
{"groups": ["group1,group2", "team3,team4"]}
% into the following list of entitlements:
["group1", "group2", "team3", "team4"]
```

* `{append, [<ruleA>, <ruleB>, ...]}` - appends lists or JSON objects together. 
Every `<rule>` must expand to a string, list or JSON. Examine possible 
combinations:
```Erlang
{append, []} ->
   []
{append, [{str, "a"}]} ->
   ["a"]
{append, [{str, "a"}, {str_list, ["c", "d"]}]} ->
   ["a", "c", "d"]
{append, [{str_list, ["a", "b"]}, {str_list, ["c", "d"]}]} ->
   ["a", "b", "c", "d"]
{append, [{keyValue, "groups"}, {keyValue, "teams"}]} ->
   {"groups": [...], "teams": [...]}
```
Example:
```Erlang
{custom => {append, [{keyValue, "organization"}, "customAttrs"]}
% provided that "customAttrs" is a nested JSON, would give something like:
{"organization": "my-org", "cusAttr1": "val1", "cusAttr2": "val2"}
```

* `{filter, "regex", <rule>}` - filters a list, leaving only the strings that 
match given "regex". `<rule>` must expand to a list of strings, or a string, 
in which case it will be treated as a list with one element. Here is an example:
```Erlang
{emails => {filter, ".*@gmail.com", "emails"}
% would leave only the emails from gmail.com
```

* `{any, [<ruleA>, <ruleB>, ...]}` - tries all rules one by one until any of
them gives a valid result. In case all of them fail, returns undefined value. 
Here is an example:
```Erlang
{fullName => {optional, {any, [{concat, [{str, "John "}, "surName"]}, "userName"]}}
% would set all users' names to:
%   a) "John <surName>" if the attribute "surName" was found
%   b) "<userName>" if the attribute "userName" was found
%   c) undefined (displayed in GUI as "Unnamed User") if none of the attributes 
%      was found (if 'optional' was changed to 'required', the login would fail).
```

The following example which use all possible rules:
```Erlang
attributeMapping => #{
    subjectId => {required, {replace, "c", "x", "id"}},
    fullName => {optional, {any, ["fullName", {join, " ", "nameTokens"}]}},
    username => undefined,
    emails => {required, {filter, ".*@my.org", {split, ",", "emails"}}},
    entitlements => {optional, {concat, [
        {str_list, ["a", "b", "c", "d"]},
        {str, ":"},
        "groups",
        {str, "/"},
        {str_list, ["1", "2", "3", "4"]}
    ]}},
    custom => {optional, {append, [
        "customAttrs",
        {keyValue, "organization"},
        {keyValue, "roles", {nested, ["roles", {list, "role"}, "displayName"]}}
    ]}}
}
```
would parse the following JSON:
```JSON
{
	"id": "abcdef1c2c3c4c",
	"nameTokens": ["John", "Doe", "Jr"],
    "username": "jodoe",
	"emails": "joedoe@example.com,john.doe@my.org",
	"groups": ["some", "entitlement", "from", "idp"],
	"roles": [
        {"role": {
            "displayName": "role1"
        }}, 
        {"role": {
            "displayName": "role2"
        }}, 
        {"role": {
            "displayName": "role3"
        }}],
	"organization": "My Organization",
	"customAttrs": {
		"thirdAttr": {
			"nested": "json"
		},
		"secondAttr": ["second", "value"],
		"fourthAttr": 17,
		"firstAttr": "firstValue"
	}
}
```
into the following Onedata user attributes:
```JSON
{
	"idp": "my-idp",
	"subjectId": "abxdef1x2x3x4x",
	"fullName": "John Doe Jr",
	"username": null,
	"emails": ["john.doe@my.org"],
	"entitlements": ["a:some/1", "b:entitlement/2", "c:from/3", "d:idp/4"],
	"custom": {
		"firstAttr": "firstValue",
		"secondAttr": ["second", "value"],
		"fourthAttr": 17,
		"thirdAttr": {
			"nested": "json"
		},
		"organization": "My Organization",
		"roles": ["role1", "role2", "role3"]
	}
}

```

#### Attribute mapping inheritance
If attribute mapping is specified in defaultProtocolConfig, it will be inherited
by all IdPs using that protocol (openid or saml) - just like all other 
attributes. It is possible to override each key in the IdP config. For example, 
the following config (default and IdP specific):
```Erlang
defaultProtocolConfig => #{
    attributeMapping => #{
        subjectId => {required, "eduPersonUniqueID"},
        fullName => {required, ["displayName", "surName"]},
        username => {optional, "eduPersonPrincipalName"},
        emails => {optional, "mail"}
    }
}
...
{my_idp, #{
    protocolConfig => #{
        attributeMapping => #{
            subjectId => {required, "eduPersonTargetedID"},
            % if not explicitly set to undefined, login rules will be
            % inherited from defaultProtocolConfig!
            username => undefined,
            entitlements => {optional, "groups"}
        }
    }
}
```
is equivalent to the following config for the given IdP:
```Erlang
{my_idp, #{
    protocolConfig => #{
        attributeMapping => #{
            subjectId => {required, "eduPersonTargetedID"},
            fullName => {required, ["displayName", "surName"]},
            username => undefined,
            emails => {optional, "mail"},
            entitlements => {optional, "groups"}
        }
    }
}
```

#### Exemplary IdP attributes

Bear in mind that typical attributes received via OpenID and SAML are different.
They differ depending on the IdP - refer to their documentation to correctly
build attribute mapping rules. Nevertheless, there is a certain set of 
universally used attributes. Please examine the following examples that use 
fairly common attributes:

OpenID attributes example (Indigo IAM)
```JSON
{
	"sub": "12345678-1234-1234-1234-12345678",
	"preferred_username": "johndoe",
	"organisation_name": "indigo-dc",
	"name": "John Doe",
	"groups": ["Users", "Developers"],
	"given_name": "John",
	"gender": "M",
	"family_name": "Doe",
	"email_verified": true,
	"email": "john.doe@google.com",
	"updated_at": "Fri Jun 17 13:52:32 CEST 2016"
}
```

SAML attributes example (Elixir Europe)
```JSON
{
	"eduPersonUniqueId": "1234567890@elixir-europe.org",
	"displayName": "John Doe",
	"eduPersonPrincipalName": "johndoe@elixir-europe.org",
	"mail": "john.doe@gmail.com",
	"eduPersonEntitlement": [
	    "elixir_test:members", 
	    "elixir_test:OneData", 
	    "elixir_test:OneData:subgroup-1", 
	    "elixir_test:OneData:subgroup-1:subgroup-2"
	],
	"https://login.elixir-europe.org/attribute-definition/forwardedScopedAffiliation/v1": "affiliate@elixir-europe.org",
	"schacHomeOrganization": "google.com"
}
```
> Although the SAML attributes are received in SAML assertions in the XML
format, they are internally normalized to JSON and treated analogically to 
OpenID attributes during attribute mapping.

SAML specification defines a certain set of attributes that can be served by 
IdPs. Onezone recognizes the most commonly used ones - see the table below. 
It presents the attribute type identifiers and their human-readable aliases used 
in Onezone. All received attributes with below identifiers will be translated
to corresponding aliases - and you must use the aliases in attribute mapping 
rules. Of course, the IdP might send attributes that are not listed in the
below table, or are completely customary for given organization. Then, in your 
attribute mapping rules, use the literal type identifiers that appear in the 
assertion XML. They might be custom strings, usually starting with `urn:oid:`,
or URIs (as in above example for Elixir) - refer to the IdP's documentation to
find out the list of supported attributes.

| alias                        | SAML attribute type identifier    |
| ---------------------------- | --------------------------------- |
| "uid"                        | urn:oid:0.9.2342.19200300.100.1.1 |
| "displayName"                | urn:oid:2.16.840.1.113730.3.1.241 |
| "givenName"                  | urn:oid:2.5.4.42                  |
| "commonName"                 | urn:oid:2.5.4.3                   |
| "surName"                    | urn:oid:2.5.4.4                   |
| "mail"                       | urn:oid:0.9.2342.19200300.100.1.3 |
| "eduPersonTargetedID"        | urn:oid:1.3.6.1.4.1.5923.1.1.1.10 |
| "eduPersonUniqueID"          | urn:oid:1.3.6.1.4.1.5923.1.1.1.13 |
| "eduPersonPrincipalName"     | urn:oid:1.3.6.1.4.1.5923.1.1.1.6  |
| "eduPersonScopedAffiliation" | urn:oid:1.3.6.1.4.1.5923.1.1.1.9  |
| "eduPersonEntitlement"       | urn:oid:1.3.6.1.4.1.5923.1.1.1.7  |
| "schacHomeOrganization"      | urn:oid:1.3.6.1.4.1.25178.1.2.9   |
| "telephoneNumber"            | urn:oid:2.5.4.20                  |
| "organizationName"           | urn:oid:2.5.4.10                  |
| "organizationalUnitName"     | urn:oid:2.5.4.11                  |
| "employeeNumber"             | urn:oid:2.16.840.1.113730.3.1.3   |
| "employeeType"               | urn:oid:2.16.840.1.113730.3.1.4   |

Exemplary attribute mapping using known and custom SAML attributes:
```Erlang
 attributeMapping => #{
    subjectId => {required, "eduPersonTargetedID"},
    fullName => {optional, {any, ["displayName", {concat, ["givenName", {str, " "}, "surName"]}]}},
    username => {optional, "eduPersonPrincipalName"},
     % Custom attribute type as a string
    email => {optional, "idp-custom-attribute"},
     % Custom attribute type in form of urn:oid:xxx
    entitlements => {optional, "urn:oid:9.9.9.9.9"},
     % Custom attribute type in form of an URI
    custom => {required, "https://login.elixir-europe.org/attribute-definition/forwardedScopedAffiliation/v1"}
 }
```


### Entitlement Mapping
Entitlement mapping is used to automatically map users entitlements in an IdP
to group memberships in Onedata. Entitlements can be understood as the right to
be a member of a group (or, possibly, a group structure) with certain 
privileges. The section in `auth.config` concerning the Entitlement Mapping has 
the following structure (example):
```Erlang
 entitlementMapping => #{
     enabled => true,
     voGroupName => "my-organization",
     adminGroup => "all_users:admins",
     parser => nested_entitlement_parser,
     parserConfig => #{
         topGroupType => unit,
         topGroupPrivilegesInVo => member,
         subGroupsType => team,
         subGroupsPrivilegesInParent => member,
         userPrivileges => member
     }
 }
```

* `enabled` - enable / disable entitlement mapping for given IdP.

* `voGroupName` - if specified, a special VO group will be created and all 
groups originating from given IdP will be added as members (subgroups) to it.
Note that if an entitlement overlaps with the `voGroupName`, it will be 
considered the same as the VO group. See the below table for examples how 
different entitlements would be mapped assuming that the `voGroupName` is set 
to `myVO`:

| entitlement            | group structure in Onedata |
| ---------------------- | -------------------------- |
| `members`              | `myVO/members`             |
| `myVO`                 | `myVO`                     |
| `myVO/members`         | `myVO/members`             |
| `users/admins`         | `myVO/users/admins`        |

* `adminGroup` - (formerly known as Super Group) if specified, it defines an
Admin Group for the given IdP. The adminGroup should be an existing entitlement,
formatted in the same way as the output of your entitlement mapping rules (refer
to the [example below](#entitlement-parsers)). The Admin Group will be granted
admin privileges to all groups originating from the specified IdP. Consequently,
all members of the Admin Group will inherit admin privileges for all groups from
that IdP.  For example, if there is an `"admins"` group in an IdP, and it is
specified as the adminGroup, users of the original `"admins"` group will be
mapped to the Onedata `"admins"` group and will automatically acquire admin
privileges in the groups associated with the IdP.

* `parser` & `parserConfig` - see below

#### Entitlement parsers

Entitlement parsers are used to convert user entitlements from an IdP to group
memberships in Onedata. There are two predefined parsers that can handle the
majority of common use cases:

* `flat_idp_group_parser` - converts every entitlement into a single group membership 
in Onedata. Each created group has a configured [group type](#group-types) 
(`groupType`) and the user with the corresponding entitlement is added to the group with 
a specified set of [privileges](#privileges-in-entitlements) (`userPrivileges`). The 
name of the group is derived from the entitlement but normalized to comply with allowed 
chars. If the IdP has a specified `voGroupName`, the group will be added as a 
subgroup with the designated set of [privileges](#privileges-in-entitlements)
(`groupPrivilegesInVo`). However, if the `voGroupName` is not specified this parameter has no 
effect.

Example:\
Let's consider the following entitlementMapping config:
```Erlang
entitlementMapping => #{
     enabled => true,
     voGroupName => "my-organization",
     adminGroup => undefined,
     parser => flat_entitlement_parser,
     parserConfig => #{
         groupType => team,
         groupPrivilegesInVo => member,
         userPrivileges => manager
     }
}
```
Suppose that the following JSON is received from the IdP:
```JSON
{
     "groups": ["developers", "admins"],
     ...
}
```
And the [attribute mapping rules](#attribute-mapping-rules) are:
```Erlang
attributeMapping => #{
     entitlements => {optional, "groups"},
     ...
}
```
Then, the following group structure would be created after the user logs in:
```
             my-organization [organization]
                 u     u
   (member privs>|     |<member privs)
                 |     |
  [team] developers   admins [team]
                u        u
  (manager privs>\      /<manager privs)
                  \    /
                  <user>
```

* `nested_entitlement_parser` - converts every entitlement into a chain of
nested groups in Onedata by splitting the input using the specified `splitWith` string. The created 
groups have configured [type](#group-types) (`topGroupType`, `subGroupsType`), 
based on their position in the structure. The user with the corresponding entitlement is
added only to the bottom group with the provided set of 
[privileges](#privileges-in-entitlements) (`userPrivileges`). The names of the 
groups are derrived from the splitting of the entitlement, but normalized 
to comply with allowed chars. If the IdP has a specified `voGroupName`, the top group will
be added as a subgroup to it with the designated set of 
[privileges](#privileges-in-entitlements) (`topGroupPrivilegesInVo`). All nested 
groups will have the [type](#group-types) of `subGroupsType` and the set of 
[privileges](#privileges-in-entitlements) specified in 
`subGroupsPrivilegesInParent` towards their parent group.

Example:\
Let's consider the following entitlementMapping config:
```Erlang
entitlementMapping => #{
     enabled => true,
     % Don't create a VO group, unlike in above
     % flat_entitlement_parser example, but define adminGroup
     voGroupName => undefined,
     adminGroup => "all_users:admins",
     parser => nested_entitlement_parser,
     parserConfig => #{
         splitWith => ":",
         topGroupType => unit,
         topGroupPrivilegesInVo => member,
         subGroupsType => team,
         subGroupsPrivilegesInParent => member,
         userPrivileges => manager
     }
```
Suppose that the following JSON is received from the IdP:
```JSON
{
     "groups": [
         "all_users:admins",
         "all_users:cloud_users:vm_managers"
     ],
     ...
}
```
And the [attribute mapping rules](#attribute-mapping-rules) are:
```Erlang
attributeMapping => #{
     entitlements => {optional, "groups"},
     ...
}
```
Then, the following group structure would be created after the user logs in:
```
                all_users [unit]
                 u     u
    (admin privs>|      \<member privs)
                 |       \
       .---------'   cloud_users [team]
      /                u   u
      \  (admin privs>/     \<member privs)
       \             /       \
        \        .--'     vm_managers [team]
         '---.  |               u    u
              \ | (admin privs>/    /<manager privs)
               \|             /    /
          [team] admins------'    /
                      u          /
        (manager privs>\        /
                        \      /
                         <user>
```

Note how the adminGroup (`"all_users:admins"`) is added to all groups in the IdP
with admin privileges. The user will inherit all those privileges and will
effectively be an admin in all those groups.


#### Group types
There are four group types in Onedata. Their purpose is to facilitate reflecting 
existing organizational hierarchies. Apart from the visual representation in GUI 
and intuitive meaning, the group type does not have a functional effect on the 
system usage. Their interpretation is up to the admins and users, but the 
recommended usage of the types is:
* `organization` - represents an organization; institution or virtual
organization (VO), e.g. "Elixir Europe"

* `unit` - represents a unit in organization, e.g. "R&D department"

* `team` - represents a collaborating team of users that address a
specific issue / topic, e.g. "WP5.1"

* `role_holders` - groups people that posses a certain role, e.g. "Admins"
(in Onedata, there is no concept of roles - rather than that, users with the 
same role/privileges should be organized in groups)


#### Privileges in entitlements
It is possible to specify privileges of the user towards the bottom group of the 
nested structure or privileges of the groups in the nested chain towards their 
parents. 

User privileges in the bottom group are set when the membership is created
and each time the privileges resulting from the entitlement mapping change.
They can be changed manually, but the changes will be overwritten by
entitlement mapping changes received from an IdP. Here is an example:

1. User logs in with entitlement "developers" and "manager" privileges.
2. User is manually granted "admin" privileges in the "developers" group.
3. User logs in again with "developers:manager" but his privileges are not
   changed because no difference since the last login is detected; he still
   has "admin" privileges.
4. User logs in again with "developers:member", which causes his privileges
   to be changed down to "member" - manual changes have been overwritten.
   
For child groups, the privileges are set only when creating a new
membership - later changes in the corresponding entitlement will NOT be
taken into account. The privileges can be changed manually without the risk
of being overwritten by the entitlement mapping.

There are four possible sets of privileges: `none`, `member`, `manager`, `admin`. 
They expand to a certain set of Onedata group privileges:
* none -> `[]`

* member -> `[group_view]`

* manager -> `[group_view,
     group_add_user, group_remove_user,
     group_add_parent, group_leave_parent,
     group_add_child, group_remove_child,
     group_add_harvester, group_remove_harvester]`
     
* admin -> `[group_view, group_view_privileges,
     group_add_user, group_remove_user,
     group_add_parent, group_leave_parent,
     group_add_child, group_remove_child,
     group_add_harvester, group_remove_harvester,
     group_update, group_delete,
     group_set_privileges,
     group_add_space, group_leave_space,
     group_add_cluster, group_leave_cluster,
     group_create_handle_service, group_leave_handle_service,
     group_create_handle, group_leave_handle]`


#### Custom entitlement parsers (advanced)
Entitlement parsers are Erlang modules that implement 
`entitlement_parser_behaviour`. They are used to convert a raw entitlement 
coming from an IdP into Onedata's internal, unified format, which looks like 
this:
```Erlang
#idp_entitlement{
     idp = myIdP,
     path = [
         #idp_group{type = organization, name = <<"my-org">>, privileges = member},
         #idp_group{type = unit, name = <<"my-unit">>, privileges = member},
         #idp_group{type = team, name = <<"my-team">>, privileges = manager}
     ],
     % user privileges in the bottom group
     privileges = admin
}
```
Such an entitlement expresses that a chain of nested groups should be created,
and the user should be added to the bottom group with the specified set of
[privileges](#privileges-in-entitlements). Each entry in the path denotes the
type and name of the group in Onedata, as well as the privileges of that group
in its parent group (if it exists). The provided entitlement would result in the
following group structure in Onezone:
```
 my-organization [organization]
     u
     |<member privs)
     |
     my-unit [unit]
         u
         |<manager privs)
         |
         my-team [team]
             u
             |<admin privs)
             |
             <user>
```
If an `adminGroup` is specified for myIdP, let's call it `"admins"`, and
the user has the following entitlements (after the mapping):
```
[
     #idp_entitlement{
         idp = myIdP,
         path = [
             #idp_group{type = organization, name = <<"my-org">>, privileges = member},
             #idp_group{type = unit, name = <<"my-unit">>, privileges = member},
             #idp_group{type = team, name = <<"my-team">>, privileges = manager}
         ],
         % user privileges in the bottom group
         privileges = admin
     },
     #idp_entitlement{
         path = [
             #idp_group{type = organization, name = <<"my-org">>, privileges = member},
             #idp_group{type = role_holder, name = <<"admins">>, privileges = <irrelevant>}
         ],
         privileges = manager
     }
]
```
Then, the following group structure would be created:
```
                         my-organization [organization]
                         u   u
                         |   |<member privs)
               .---------'   |
  (admin privs>|             my-unit [unit]
               |             u   u
               | .-----------'   |<manager privs)
               | |               |
               | |<admin privs)  my-team [team]
               | |                u   u
               | |   (admin privs>|   |<admin privs)
               | |                |   |
 [role_holder] admins-------------'   |
                  u                   |
   (manager privs>|                   |
                  '----------------- <user>
```
Furthermore, if `voGroupName` is specified as `"my-vo-group"`, the whole 
structure is added as children to that VO (organization) group. In such case, 
the above entitlements would result in the following group structure:
```
           my-vo-group [organization]
              u   u
 (admin privs>|   |<member privs)
              |   |
       .------'   '---------------my-organization [organization]
       |                          u   u
       |                          |   |<member privs)
       |                .---------'   |
       |   (admin privs>|             my-unit [unit]
       |                |             u   u
       |                | .-----------'   |<manager privs)
       |                | |               |
       |                | |<admin privs)  my-team [team]
       |                | |                u   u
       '--------------. | |   (admin privs>|   |<admin privs)
                       \| |                |   |
         [role_holder] admins--------------'   |
                           u                   |
            (manager privs>|                   |
                           '----------------- <user>
```

To implement your own entitlement parser, see 
[entitlement parser](#entitlement-parser).


## Auth plugins
Auth plugins are user-defined Erlang modules that can be injected into the
Onezone service and used to customize OIDC / SAML sing-on procedure. All plugins 
must be Erlang files with `".erl"` extension which are expected to be found in the 
plugins directory `/var/lib/oz_worker/plugins`.

The plugins are loaded upon Onezone startup. When using a deployment with more 
than one node, the same plugins must be provisioned on all nodes.

> If you wish to implement your own auth plugin, we recommend to contact us 
(e.g. create an issue on [GitHub](https://github.com/onedata/)) to make the
process as smooth as possible.

Plugins must conform to predefined API that is specified in Erlang behaviour
modules. Please refer to the oz-worker source code for the behaviours and
implementation guide.

Each plugin must implement the `onezone_plugin_behaviour`, which has one
callback - `type/0`, that returns the type of the plugin:
`attribute_mapper | entitlement_parser | openid_plugin`.

> See the corresponding behaviours for more info.
> `entitlement_parser` and `attribute_mapper` support validation examples that
will be evaluated upon startup and the results will be logged in Onezone logs.


### Attribute mapper
This auth plugin maps IdP attributes into Onedata attributes. It must implement
the `onezone_plugin_behaviour` that returns the `attribute_mapper` atom from the 
`type/0` callback, and the `attribute_mapper_behaviour`. Refer to the
[oz-worker source code](https://github.com/onedata/oz-worker) for the
behaviour module and implementation details. An exemplary custom attribute 
mapper (`custom_attribute_mapper.erl`) can be found in the 
[plugins directory](#auth-plugins).


### Entitlement parser
This auth plugin maps IdP entitlements into Onedata entitlements 
(group memberships). It must implement the `onezone_plugin_behaviour` that returns 
the `entitlement_parser` atom from the `type/0` callback, and the 
`entitlement_parser_behaviour`. Refer to the
[oz-worker source code](https://github.com/onedata/oz-worker) for the
behaviour module and implementation details. An exemplary custom entitlement 
parser that supports EGI group format (`custom_entitlement_parser.erl`) can be 
found in the [plugins directory](#auth-plugins).


### OpenID plugin
This auth plugin handles the Open ID login process. It must implement the 
`onezone_plugin_behaviour` that returns the `openid_plugin` atom from the `type/0` 
callback, and the `openid_plugin_behaviour`. Refer to the
[oz-worker source code](https://github.com/onedata/oz-worker) for the
behaviour module and implementation details. 


## Troubleshooting

If any of the features is not working as expected, please go through this 
checklist that might help identify the problem:

* Make sure that you have correctly placed or overwritten the `auth.config` file. Go
to the Onezone node and examine `/etc/oz_worker/auth.config`. Especially in
docker-based deployments, it is possible that changes made to the file on your
host may not be reflected in the container.

* Wait for the `auth.config` to be reloaded - the config is cached for 60 
seconds, and any changes you introduce might take up to this time to be visible.

* If any error occurs during the login process, see what page you are currently
on:
    * **The IdP page** - either your `auth.config` has errors (the error on the 
    IdP page should indicate the reason), or the problem is on the IdP side. In 
    any case, try contacting the administrators, who can examine their logs and
    give you hints on the reason.

    * **The Onezone GUI** - see the image below. The error page will contain 
    basic information about the error. If that is not enough to identify the 
    problem, copy the request state identifier from the error page and check the 
    logs - see the next point.
    
    <img style="display:block;margin:0 auto;"
    src="../../../../images/admin-guide/onezone/configuration/oidc-saml/login-page-error.png#screenshot">
    <!-- FIXME - replace with actual one -->

* Check [Onezone logs](../onezone_tutorial.md#logs) for any hints what might 
have gone wrong:
    * Errors in `auth.config` are logged on the `alert` loglevel, they should 
    give clear information on how to fix the config.
    
    * Erroneous requests are logged on different loglevels, depending on the 
    error severity. They always include the request state identifier (see the 
    image above), so they are easy to look up.
    
    * Some of the errors with low severity are logged on the `debug` loglevel, 
    which is disabled by default. If needed, you can 
    [turn on the `debug` logs](../onezone_tutorial.md#enabling-debug-logs) 
    (keep in mind that they have negative impact on the system performance). 
    After doing so, go through the login process again and take the request 
    state identifier. You will get detailed logs from the whole login process - 
    look them up using the state identifier. Remember to turn off the debug logs 
    when you are finished.


## LUMA Integration
The attributes and entitlements collected from IdPs can be very useful for 
mapping storage users to Onedata users - see 
[Local User MApping (LUMA)](../luma.md). 
When a provider requests LUMA to resolve storage credentials such as uid and
gid, it includes the attributes collected from IdPs. These attributes can be
utilized to differentiate and identify the storage users effectively.

## Custom icon guidelines

To use your custom icon on the login page, place it on the Onezone host under the 
path `/var/www/html/oz_worker/custom/<path>` and reference it in the config like 
this: `iconPath => "/custom/<path>"`. If you are using docker-compose, simply 
mount your icon by adding a volume, for example: 
```
# docker-compose.yaml

    ...
    volumes:
      - "/path/to/your/icon.svg:/var/www/html/oz_worker/custom/my-icon.svg"
    ...
      
----------------------------------------------
# test.auth.config

    ...
    iconPath => "/custom/my-icon.svg",
    ...
```

> NOTE: The path has changed from `/var/www/html/custom/oz_worker/<path>` 
compared to previous config version.

Please follow the guidelines below for the best visual effects:
* The preferred image format is vector graphics in SVG.
* Avoid raster (bitmap) graphics embedded in an SVG - some browsers
(e.g. Firefox) do not handle them well.
* If you don't have an SVG version, PNG with transparency is preferred over JPG. 
* It's best if your icon is placed on a square canvas (see the image below).
* The canvas should be transparent, in such case `iconBackground` color will be
visible underneath. You can use a custom background, but make sure you fill the
whole canvas with it and make it a perfect square, otherwise the background 
color might show through.
* In case of a bitmap image (PNG, JPG), the canvas size should be 50x50 pixels,
or any multiple of it. Consider the size of 200x200 pixels for good quality on 
retina displays.
* The icon canvas takes up the whole space on the login button. It means that 
there are no automatic margins - you should introduce the desired margins on 
the canvas (see the image below).
* Make sure to center you icon on the image canvas (unless, of course, you want
it to be asymmetric).

<img style="display:block;margin:0 auto;"
src="../../../../images/admin-guide/onezone/configuration/oidc-saml/custom-icon.png#screenshot">
<!-- FIXME - replace with actual one -->


## Test login page

It is possible to test your `auth.config` using the 
test login page without interrupting the Onezone service. It also serves as a
way to diagnose problems during integration with IdPs, including attribute or
entitlement mapping. To use the test login page, place your `auth.config` on the 
Onezone host under the path `/etc/oz_worker/test.auth.config`. The test config
coexists with the production `/etc/oz_worker/auth.config` with no interference. 
It is not cached at all, so that you can introduce changes while the Onezone 
service is online and verify the results immediately. To go through the test 
login process, go to `https://onezone.example.com/#/test/login`. You will see 
the IdPs that are specified in your `test.auth.config` and an indication that 
this is a test login page (see the first image below). By choosing one of the 
IdPs, you will go through a simulation of the login process and receive a 
summary at the end (see the second image below). While it uses the standard flow 
in the IdP, on the Onezone side no users or groups (resulting from entitlements) 
are created in the process. The summary expresses what information would be 
gathered if it were a production login flow, and includes detailed logs from the 
whole login process. 

> The SAML SP metadata XML based on `test.auth.config` can be viewed under the
following URL: `https://onezone.example.com/saml/sp.xml?test=true`

<img style="display:block;margin:0 auto;"
src="../../../../images/admin-guide/onezone/configuration/oidc-saml/test-login-page.png#screenshot">
<!-- FIXME - replace with actual one -->

<img style="display:block;margin:0 auto;"
src="../../../../images/admin-guide/onezone/configuration/oidc-saml/test-login-output.png#screenshot">
<!-- FIXME - replace with actual one -->


## Complete example

A complete exemplary `auth.config` file is presented below. It can also be found
on your Onezone node under `/etc/oz_worker/template.auth.config`.

```Erlang
#{
    version => 3,

    % Allows to log in to Onezone using username & password.
    basicAuthConfig => #{
        enabled => true
    },

    openidConfig => #{
        % Enable OpenID login protocol - if disabled, all OpenID IdPs will be
        % hidden from the login page.
        enabled => true,
        % Default config for every OpenID IdP, can be overridden in IdP config
        defaultProtocolConfig => #{
            % Internal plugin that will be used for handling the login process -
            % if the IdP uses standard OpenID Connect protocol,
            % default_oidc_plugin is the way to go. If not, IdP specific plugin
            % can be implemented and specified here.
            plugin => default_oidc_plugin,
            % Config specific for default_oidc_plugin
            pluginConfig => #{
                % Scope requested from OpenID Connect IdP
                scope => "openid email profile",
                % HTTP method used to exchange auth code for an access token: post | get
                accessTokenAcquireMethod => post,
                % How the client secret should be sent to the IdP: urlencoded | inAuthHeader
                clientSecretPassMethod => urlencoded,
                % How user's access token should be sent to the IdP: urlencoded | inAuthHeader
                accessTokenPassMethod => inAuthHeader,
                % Allows to augment requests with additional data
                customData => #{
                    % Additional data for access_token endpoint request
                    accessToken => #{
                        % query string or post body parameters (key-value)
                        parameters => undefined,
                        % headers (key-value)
                        headers => undefined
                    },
                    % Additional data for userinfo endpoint request
                    userInfo => #{
                        parameters => undefined,
                        headers => undefined
                    }
                }
            },
            % Enables/disables authorization using access tokens from the IdP
            % Supported only in OpenID protocol
            authorityDelegation => #{
                % Enabled for this IdP
                enabled => true
                % The tokenPrefix attribute defines a prefix used to distinguish
                % tokens from given IdP. It defaults to "<idp>:", where <idp> is
                % the identifier used in config. Can be overriden in IdP config,
                % like the following:
                %       tokenPrefix => "my-idp/"
                % Exemplary token usage with with such config:
                % curl -H "X-Auth-Token: my-idp/lkj9s87rf1234SDfh6721hqd7991" ...
            },
            % Defines how the attributes from OpenID user info should be mapped
            % to Onedata user attributes. Attributes must correspond to existing
            % OpenID attributes.
            attributeMapping => #{
                subjectId => {required, "sub"},
                fullName => {required, {any, ["name", "fullName"]}},
                username => {optional, "username"},
                emails => {optional, "email"},
                entitlements => {optional, "groups"},
                custom => {optional, "name"}
            },
            % Rules for mapping entitlements in the IdP into entitlements in Onedata.
            entitlementMapping => #{
                enabled => false
            }
        }
    },

    samlConfig => #{
        % Enable SAML login protocol - if disabled, all SAML IdPs will be hidden
        % from the login page and the endpoint serving SAML metadata will be
        % disabled.
        enabled => true,
        % Information used to build SAML SP metadata XML, refer to SAML
        % documentation for details on below attributes.
        spConfig => #{
            entityId => "https://onezone.example.com/sp",
            certFile => "/etc/oz_worker/certs/saml_cert.pem",
            keyFile => "/etc/oz_worker/certs/saml_key.pem",
            organizationName => "My organization",
            organizationDisplayName => "My organization",
            techContactName => "John Doe",
            techContactEmail => "john.doe@onezone.example.com",
            % Should the metadata be signed with keyFile
            signMetadata => false,
            % Should the Auth Requests be signed with keyFile
            signRequests => true,
            % Should Onezone request signed assertions
            wantAssertionsSigned => true
        },
        % Default config for every SAML IdP, can be overridden in IdP config
        defaultProtocolConfig => #{
            % SSO binding - defines what type of request should be performed
            % to redirect the user to the IdP's login page. Possible values:
            % http_redirect (default) or http_post
            preferredSsoBinding => http_redirect,
            % Defines how the attributes from SAML user info should be mapped
            % to Onedata user attributes. Attributes must correspond to existing
            % SAML attributes.
            attributeMapping => #{
                subjectId => {required, "eduPersonTargetedID"},
                fullName => {required, {any, ["displayName", "surName"]}},
                username => {optional, "eduPersonPrincipalName"},
                emails => {optional, "mail"},
                entitlements => {optional, "eduPersonEntitlement"},
                custom => {optional, "eduPersonScopedAffiliation"}
            },
            % Rules for mapping entitlements in IdP into entitlements in Onedata.
            entitlementMapping => #{
                % Enable / disable entitlement mapping for given IdP
                enabled => true,
                % The name of the parent group to which all groups from this IdP
                % will belong (reflecting a Virtual Organization)
                voGroupName => undefined,
                % A special group that has admin rights to all groups from this
                % IdP.
                adminGroup => undefined,
                % Erlang module (plugin) that will be used to parse user's
                % entitlements from this IdP
                parser => nested_entitlement_parser,
                % Config specific for the nested_entitlement_parser
                parserConfig => #{
                    splitWith => "/",
                    topGroupType => unit,
                    topGroupPrivilegesInVo => member,
                    subGroupsType => team,
                    subGroupsPrivilegesInParent => member,
                    userPrivileges => member
                }
            }
        }
    },

    supportedIdps => [

        % basicAuth is a special IdP id reserved for signing in with username & password 
        % and the only valid config entry using the basicAuth protocol.
        {basicAuth, #{
            % Configuration of the login page button
            displayName => "username & password",
            % Some predefined icons are built-in into the GUI app.
            % Their paths start with /assets/images/auth-providers.
            % For a custom icon, put it in:
            %   /var/www/html/oz_worker/custom/<path>
            % And reference it here like this: /custom/<path>
            iconPath => "/assets/images/auth-providers/basicauth.svg",
            % Background color is useful for icons with transparency. Moreover,
            % after selecting an IdP, its icon disappears and a spinner is
            % shown - hence background color should be kept the same as icon's
            % background color (if any).
            iconBackgroundColor => "#4BD187",

            % Which protocol is used for this IdP - basicAuth is the only
            % valid one for basicAuth IdP.
            protocol => basicAuth
        }},

        {google, #{
            % Configuration of the login page button
            displayName => "Google",
            % Some predefined icons are built-in into the GUI app.
            % Their paths start with /assets/images/auth-providers.
            % For a custom icon, put it in:
            %   /var/www/html/oz_worker/custom/<path>
            % And reference it here like this: /custom/<path>
            iconPath => "/assets/images/auth-providers/google.svg",
            % Background color is useful for icons with transparency. Moreover,
            % after selecting an IdP, its icon disappears and a spinner is
            % shown - hence background color should be kept the same as icon's
            % background color (if any).
            iconBackgroundColor => "#F1514F",

            % Which protocol is used for this IdP
            protocol => openid,
            % Configuration specific for OpenID protocol - overrides the default
            protocolConfig => #{
                % Internal plugin that will be used for handling the login process -
                % if the IdP uses standard OpenID Connect protocol,
                % default_oidc_plugin is the way to go. If not, IdP specific plugin
                % can be implemented and specified here.
                plugin => default_oidc_plugin,
                % Config specific for default_oidc_plugin
                pluginConfig => #{
                    % Client Id and secret acquired during registration
                    clientId => "****************************************************",
                    clientSecret => "****************************************************",
                    % Defines how to resolve OpenID endpoints
                    endpoints => #{
                        % The XRDS endpoint, will be used if referenced in below endpoints
                        xrds => "https://accounts.google.com/.well-known/openid-configuration",
                        % standard OIDC endpoints - literal URLs or tuples {xrds, "key"} -
                        % "key" will be extracted from the XRDS JSON.
                        authorize => {xrds, "authorization_endpoint"},
                        accessToken => {xrds, "token_endpoint"},
                        userInfo => {xrds, "userinfo_endpoint"}
                    },
                    % Scope requested from OpenID Connect IdP
                    scope => "openid email profile",
                    % HTTP method used to exchange auth code for an access token: post | get
                    accessTokenAcquireMethod => post,
                    % How the client secret should be sent to the IdP: urlencoded | inAuthHeader
                    clientSecretPassMethod => urlencoded,
                    % How user's access token should be sent to the IdP: urlencoded | inAuthHeader
                    accessTokenPassMethod => inAuthHeader,
                    % Allows to augment requests with additional data
                    customData => #{
                        % Additional data for access_token endpoint request
                        accessToken => #{
                            % query string or post body parameters (key-value)
                            parameters => #{"param1" => "val1"},
                            % headers (key-value)
                            headers => #{"header1" => "val1"}
                        },
                        % Additional data for userinfo endpoint request
                        userInfo => #{
                            parameters => #{"param2" => "val2"},
                            headers => #{"header2" => "val2"}
                        }
                    }
                },

                % Enables/disables authorization using access tokens from the IdP
                % Supported only in OpenID protocol
                authorityDelegation => #{
                    % Enabled for this IdP
                    enabled => true,
                    % The tokenPrefix attribute defines a prefix used to distinguish
                    % tokens from given IdP.
                    % Exemplary token usage with the below such config:
                    % curl -H "X-Auth-Token: google:lkj9s87rf1234SDfh6721hqd7991" ...
                    tokenPrefix => "google:"
                },
                % Defines how the attributes from OpenID user info should be mapped
                % to Onedata user attributes. Attributes must correspond to existing
                % OpenID attributes.
                attributeMapping => #{
                    subjectId => {required, "sub"},
                    fullName => {required, {any, ["name", "fullName"]}},
                    username => {optional, "username"},
                    emails => {optional, "email"},
                    entitlements => {optional, "given_name"},
                    custom => {optional, "given_name"}
                },
                % Rules for mapping entitlements in the IdP into entitlements in Onedata.
                entitlementMapping => #{
                    enabled => true,
                    % The name of the parent group to which all groups from this IdP
                    % will belong (reflecting a Virtual Organization)
                    voGroupName => undefined,
                    % A special group that has admin rights to all groups from this
                    % IdP.
                    adminGroup => undefined,
                    parser => flat_entitlement_parser,
                    parserConfig => #{
                        groupType => team,
                        groupPrivilegesInVo => member,
                        userPrivileges => member
                    }
                }
            }
        }},

        {elixir, #{
            % Configuration of the login page button
            displayName => "Elixir",
            % To use the icon like below, put it in:
            
            %   /var/www/html/oz_worker/custom/images/elixir.svg
            iconPath => "/custom/images/elixir.svg",
            % Background color is useful for icons with transparency. Moreover,
            % after selecting an IdP, its icon disappears and a spinner is
            % shown - hence background color should be kept the same as icon's
            % background color (if any).
            iconBackgroundColor => "#FF7A04",

            % Which protocol is used for this IdP
            protocol => saml,
            % Configuration specific for SAML protocol - overrides the default
            protocolConfig => #{
                % URL pointing to IdP SAML metadata XML
                metadataUrl => "https://login.elixir-czech.org/proxy/saml2/idp/metadata.php",
                % SSO binding - defines what type of request should be performed
                % to redirect the user to the IdP's login page. Possible values:
                % http_redirect (default) or http_post
                preferredSsoBinding => http_redirect,
                % Defines how the attributes from SAML user info should be mapped
                % to Onedata user attributes. Attributes must correspond to existing
                % SAML attributes.
                attributeMapping => #{
                    subjectId => {required, "eduPersonUniqueId"},
                    fullName => {required, "displayName"},
                    username => {optional, "eduPersonPrincipalName"},
                    emails => {optional, "mail"},
                    entitlements => {optional, "eduPersonEntitlement"},
                    custom => {optional, "eduPersonScopedAffiliation"}
                },
                % Rules for mapping entitlements in IdP into entitlements in Onedata.
                entitlementMapping => #{
                    % Enable / disable entitlement mapping for given IdP
                    enabled => true,
                    % The name of the parent group to which all groups from this IdP
                    % will belong (reflecting a Virtual Organization)
                    voGroupName => "Elixir",
                    % A special group that has admin rights to all groups from this
                    % IdP.
                    adminGroup => "elixir_test:tsi-admin",
                    % Erlang module (plugin) that will be used to parse user's
                    % entitlements from this IdP
                    parser => nested_entitlement_parser,
                    % Config specific for the nested_entitlement_parser
                    parserConfig => #{
                        splitWith => ":",
                        topGroupType => unit,
                        topGroupPrivilegesInVo => member,
                        subGroupsType => team,
                        subGroupsPrivilegesInParent => member,
                        userPrivileges => member
                    }
                }
            }
        }}
    ]
}.
```

## Minimal config

Minimal config that enables only basic auth (username & password login) - 
included by default in Onezone installation.

```Erlang
#{
    version => 3,

    basicAuthConfig => #{
        enabled => true
    },

    samlConfig => #{
        enabled => false
    },

    openidConfig => #{
        enabled => false
    },

    supportedIdps => [
        {basicAuth, #{
            displayName => "username & password",
            iconPath => "/assets/images/auth-providers/basicauth.svg",
            iconBackgroundColor => "#4BD187",
            protocol => basicAuth
        }}
    ]
}.
```


## Exemplary entries for selected IdPs

Below are some working config examples that use predefined icons, to be placed
in the `supportedIdps` section of the config. In case of OpenID IdPs, it is 
required to insert the Client Id and Secret in the config.


### username & password login
```Erlang
{basicAuth, #{
    displayName => "username & password",
    iconPath => "/assets/images/auth-providers/basicauth.svg",
    iconBackgroundColor => "#4BD187",
    protocol => basicAuth
}}
```


### KeyCloak config (OpenID Connect)
```Erlang
{keycloakIdP, #{
    displayName => "RHEA KeyCloak",
    iconPath => "/assets/images/auth-providers/rhea.svg",
    iconBackgroundColor => "#B51017",
    protocol => openid,
    protocolConfig => #{
        plugin => default_oidc_plugin,
        pluginConfig => #{
            clientId => "****************************************************",
            clientSecret => "****************************************************",
            endpoints => #{
                xrds => "https://fed-id.nuv.la/auth/realms/SixSq/.well-known/openid-configuration",
                authorize => {xrds, "authorization_endpoint"},
                accessToken => {xrds, "token_endpoint"},
                userInfo => {xrds, "userinfo_endpoint"}
            },
            scope => "openid email profile",
            accessTokenAcquireMethod => post,
            clientSecretPassMethod => urlencoded,
            accessTokenPassMethod => inAuthHeader,
            customData => #{}
        },
    
        authorityDelegation => #{
            enabled => true,
            tokenPrefix => "keycloakIdP:"
        },
    
        attributeMapping => #{
            subjectId => {required, "sub"},
            fullName => {required, {any, ["name", "fullName"]}},
            username => {optional, "username"},
            emails => {optional, "email"},
            entitlements => {optional, {append, ["groups", "roles"]}},
            custom => {optional, "given_name"}
        },
    
        entitlementMapping => #{
            enabled => true,
            voGroupName => "Keycloak IdP",
            adminGroup = undefined,
            parser => nested_entitlement_parser,
            parserConfig => #{
                splitWith => "/",
                topGroupType => team,
                topGroupPrivilegesInVo => member,
                subGroupsType => team,
                subGroupsPrivilegesInParent => member,
                userPrivileges => member
            }
        }
    }
}}
```


### Google+ config (OpenID Connect)
```Erlang
{google, #{
    displayName => "Google",
    iconPath => "/assets/images/auth-providers/google.svg",
    iconBackgroundColor => "#F1514F",
    protocol => openid,
    protocolConfig => #{
        plugin => default_oidc_plugin,
        pluginConfig => #{
            clientId => "****************************************************",
            clientSecret => "****************************************************",
            endpoints => #{
                xrds => "https://accounts.google.com/.well-known/openid-configuration",
                authorize => {xrds, "authorization_endpoint"},
                accessToken => {xrds, "token_endpoint"},
                userInfo => {xrds, "userinfo_endpoint"}
            },
            scope => "openid email profile",
            accessTokenAcquireMethod => post,
            clientSecretPassMethod => urlencoded,
            accessTokenPassMethod => urlencoded,
            customData => #{}
        },
        
        authorityDelegation => #{
            enabled => true,
            tokenPrefix => "google:"
        },

        attributeMapping => #{
            subjectId => {required, "sub"},
            fullName => {required, {any, ["name", "fullName"]}},
            username => {optional, "username"},
            emails => {optional, "email"},
            entitlements => undefined,
            custom => undefined
        },

        entitlementMapping => #{
            enabled => false
        }
    }
}}
```


### Facebook config (OpenID Connect)
```Erlang
{facebook, #{
    displayName => "Facebook",
    iconPath => "/assets/images/auth-providers/facebook.svg",
    iconBackgroundColor => "#5B87C5",
    protocol => openid,
    protocolConfig => #{
        plugin => default_oidc_plugin,
        pluginConfig => #{
            clientId => "****************************************************",
            clientSecret => "****************************************************",
            endpoints => #{
                authorize => "https://www.facebook.com/dialog/oauth",
                accessToken => "https://graph.facebook.com/oauth/access_token",
                userInfo => "https://graph.facebook.com/me"
            },
            scope => "email",
            accessTokenAcquireMethod => get,
            clientSecretPassMethod => urlencoded,
            accessTokenPassMethod => urlencoded,
            customData => #{
                userInfo => #{
                    parameters => #{
                        "fields" => "email,name"
                    }
                }
            }
        },

        authorityDelegation => #{
            enabled => true,
            tokenPrefix => "facebook:"
        },

        attributeMapping => #{
            subjectId => {required, "id"},
            fullName => {required, {any, ["name", "fullName"]}},
            username => {optional, "username"},
            emails => {optional, "email"},
            entitlements => undefined,
            custom => undefined
        },

        entitlementMapping => #{
            enabled => false
        }
}}
```


### GitHub config (OpenID Connect)
```Erlang
{github, #{
    displayName => "Github",
    iconPath => "/assets/images/auth-providers/github.svg",
    iconBackgroundColor => "#1E2325",
    protocol => openid,
    protocolConfig => #{
        plugin => default_oidc_plugin,
        pluginConfig => #{
            clientId => "****************************************************",
            clientSecret => "****************************************************",
            endpoints => #{
                authorize => "https://github.com/login/oauth/authorize",
                accessToken => "https://github.com/login/oauth/access_token",
                userInfo => [
                    "https://api.github.com/user",
                    {"emails", "https://api.github.com/user/emails"}
                ]
            },
            scope => "user,user:email",
            accessTokenAcquireMethod => post,
            clientSecretPassMethod => urlencoded,
            accessTokenPassMethod => urlencoded,
            customData => #{
                userInfo => #{
                    headers => #{
                        "User-Agent" => "Onedata"
                    }
                }
            }
        },

        authorityDelegation => #{
            enabled => true,
            tokenPrefix => "github:"
        },

        attributeMapping => #{
            subjectId => {required, "id"},
            fullName => {required, {any, ["name", "fullName"]}},
            username => {optional, "username"},
            emails => {optional, {nested, ["emails", {list, "email"}]}},
            entitlements => undefined,
            custom => undefined
        },

        entitlementMapping => #{
            enabled => false
        }
}}
```


### Indigo config (OpenID Connect)
```Erlang
{indigo, #{
    displayName => "Indigo",
    iconPath => "/assets/images/auth-providers/indigo.svg",
    iconBackgroundColor => "#341246",
    protocol => openid,
    protocolConfig => #{
        plugin => default_oidc_plugin,
        pluginConfig => #{
            clientId => "****************************************************",
            clientSecret => "****************************************************",
            endpoints => #{
                xrds => "https://iam-test.indigo-datacloud.eu/.well-known/openid-configuration",
                authorize => {xrds, "authorization_endpoint"},
                accessToken => {xrds, "token_endpoint"},
                userInfo => {xrds, "userinfo_endpoint"}
            },
            scope => "openid email profile",
            accessTokenAcquireMethod => post,
            clientSecretPassMethod => inAuthHeader,
            accessTokenPassMethod => urlencoded,
            customData => #{}
        },
        
        authorityDelegation => #{
            enabled => true,
            tokenPrefix => "indigo:"
        },
    
        attributeMapping => #{
            subjectId => {required, "sub"},
            fullName => {required, {any, ["name", {concat, ["given_name", {str, " "}, "family_name"]}]}},
            username => {optional, "preferred_username"},
            emails => {optional, "email"},
            entitlements => {optional, "groups"},
            custom => {optional, "given_name"}
        },
    
        entitlementMapping => #{
            enabled => true,
            voGroupName => "Indigo",
            adminGroup => "Admins",
            parser => nested_entitlement_parser,
            parserConfig => #{
                splitWith => "/",
                topGroupType => unit,
                topGroupPrivilegesInVo => member,
                subGroupsType => team,
                subGroupsPrivilegesInParent => member,
                userPrivileges => member
            }
        }
}}
```


### EGI config (OpenID Connect)
```Erlang
{egi, #{
    displayName => "EGI",
    iconPath => "/assets/images/auth-providers/egi.svg",
    iconBackgroundColor => "#0455A1",
    protocol => openid,
    protocolConfig => #{
        plugin => default_oidc_plugin,
        pluginConfig => #{
            clientId => "****************************************************",
            clientSecret => "****************************************************",
            endpoints => #{
                xrds => "https://aai.egi.eu/oidc/.well-known/openid-configuration",
                authorize => {xrds, "authorization_endpoint"},
                accessToken => {xrds, "token_endpoint"},
                userInfo => {xrds, "userinfo_endpoint"}
            },
            scope => "openid email profile",
            accessTokenAcquireMethod => post,
            clientSecretPassMethod => inAuthHeader,
            accessTokenPassMethod => urlencoded,
            customData => #{}
        },

        authorityDelegation => #{
            enabled => true,
            tokenPrefix => "egi:"
        },

        attributeMapping => #{
            subjectId => {required, "sub"},
            fullName => {required, {any, ["name", {concat, ["given_name", {str, " "}, "family_name"]}]}},
            username => {optional, "preferred_username"},
            emails => {optional, "email"},
            entitlements => {optional, {filter, ".*#.*", "edu_person_entitlements"}},
            custom => undefined
        },

        entitlementMapping => #{
            enabled => true,
            voGroupName => "EGI",
            parser => custom_entitlement_parser
        }
}}
```


### PLGrid config (OpenID 2.0)
```Erlang
{plgrid, #{
     displayName => "PLGrid OpenID",
     iconPath => "/assets/images/auth-providers/plgrid.svg",
     iconBackgroundColor => "#026381",
     protocol => openid,
     protocolConfig => #{
         plugin => plgrid_oidc_plugin,
         pluginConfig => #{
             xrds_endpoint => "https://openid.plgrid.pl/gateway"
         },
    
         authorityDelegation => #{
             enabled => false
         },
    
         attributeMapping => #{
             subjectId => {required, "openid.sreg.nickname"},
             fullName => {required, "openid.sreg.fullname"},
             username => {optional, "openid.sreg.nickname"},
             emails => {optional, "openid.sreg.email"},
             entitlements => {optional, "openid.ext1.value.teams"},
             custom => undefined
         },
    
         entitlementMapping => #{
             enabled => true,
             parser => flat_entitlement_parser,
             parserConfig => #{
                 groupType => team,
                 groupPrivilegesInVo => member,
                 userPrivileges => member
             }
         }
     }
}}
```


### CERN config (SAML)
```Erlang
{cern, #{
    displayName => <<"CERN (eduGAIN)">>,
    iconBackgroundColor => <<"#0053A1">>,
    iconPath => <<"/assets/images/auth-providers/cern.svg">>,
    protocol => saml,
    protocolConfig => #{
        metadataUrl => "https://met.refeds.org/met/entity/https%3A//cern.ch/login/?viewxml=true&federation=incommon-federation",
        preferredSsoBinding => http_post,
        attributeMapping => #{
            subjectId => {required, "eduPersonUniqueID"},
            fullName => {optional, "displayName"},
            username => {optional, "eduPersonPrincipalName"},
            email => {optional, "mail"},
            entitlements => {optional, "eduPersonAffiliation"},
            custom => undefined
        },
        entitlementMapping => #{
            enabled => false,
            adminGroup => undefined,
            voGroupName => "cern",
            parser => flat_entitlement_parser,
            parserConfig => #{
                groupPrivilegesInVo => member,
                groupType => team,
                userPrivileges => member
            }
        }
    }
}}
```


### CNRS config (SAML)
```Erlang
{cnrs, #{
    displayName => <<"CNRS (eduGAIN)">>,
    iconBackgroundColor => <<"#FFF">>,
    iconPath => <<"/assets/images/auth-providers/cnrs.svg">>,
    protocol => saml,
    protocolConfig => #{
        metadataUrl => "https://met.refeds.org/met/entity/https%3A//janus.cnrs.fr/idp/?viewxml=true&federation=federation-education-recherche",
        preferredSsoBinding => http_redirect,
        attributeMapping => #{
            subjectId => {required, "eduPersonTargetedID"},
            fullName => {optional, "displayName"},
            username => {optional, "eduPersonPrincipalName"},
            email => {optional, "mail"},
            entitlements => {optional, "eduPersonEntitlement"},
            custom => undefined
        },
        entitlementMapping => #{
            enabled => false,
            adminGroup => undefined,
            voGroupName => "cnrs",
            parser => flat_entitlement_parser,
            parserConfig => #{
                groupPrivilegesInVo => member,
                groupType => team,
                userPrivileges => member
            }
        }
    }
}}
```


### DESY config (SAML)
```Erlang
{desy, #{
    displayName => <<"DESY (eduGAIN)">>,
    iconBackgroundColor => <<"#FFF">>,
    iconPath => <<"/assets/images/auth-providers/desy.svg">>,
    protocol => saml,
    protocolConfig => #{
        metadataUrl => "https://idp1.desy.de/idp/shibboleth",
        preferredSsoBinding => http_redirect,
        attributeMapping => #{
            subjectId => {required, "eduPersonPrincipalName"},
            fullName => {optional, "displayName"},
            username => {optional, "eduPersonPrincipalName"},
            email => {optional, "mail"},
            entitlements => {optional, "eduPersonEntitlement"},
            custom => undefined
        },
        entitlementMapping => #{
            enabled => false,
            adminGroup => undefined,
            voGroupName => "desy",
            parser => flat_entitlement_parser,
            parserConfig => #{
                groupPrivilegesInVo => member,
                groupType => team,
                userPrivileges => member
            }
        }
    }
}}
```


### Elixir config (SAML)
```Erlang
{elixir, #{
    displayName => <<"Elixir">>,
    iconBackgroundColor => <<"#FF7A04">>,
    iconPath => <<"/assets/images/auth-providers/elixir.svg">>,
    protocol => saml,
    protocolConfig => #{
        metadataUrl => "https://login.elixir-czech.org/proxy/saml2/idp/metadata.php",
        preferredSsoBinding => http_redirect,
        attributeMapping => #{
            subjectId => {required, "eduPersonUniqueID"},
            fullName => {optional, "displayName"},
            username => {optional, "eduPersonPrincipalName"},
            email => {optional, "mail"},
            entitlements => {optional, "eduPersonEntitlement"},
            custom => undefined
        },
        entitlementMapping => #{
            enabled => true,
            adminGroup => "vo:elixir_test/tm:HNSciCloud/tm:tsi-admin",
            voGroupName => "elixir",
            parser => flat_entitlement_parser,
            parserConfig => #{
                groupPrivilegesInVo => member,
                groupType => team,
                userPrivileges => member
            }
        }
    }
}}
```


### EMBL config (SAML)
```Erlang
{embl, #{
    displayName => <<"EMBL (eduGAIN)">>,
    iconBackgroundColor => <<"#FFF">>,
    iconPath => <<"/assets/images/auth-providers/embl.svg">>,
    protocol => saml,
    protocolConfig => #{
        metadataUrl => "https://idp.ebi.ac.uk/idp/shibboleth",
        preferredSsoBinding => http_redirect,
        attributeMapping => #{
            subjectId => {required, "eduPersonTargetedID"},
            fullName => {optional, "displayName"},
            username => {optional, "eduPersonPrincipalName"},
            email => {optional, "mail"},
            entitlements => {optional, "eduPersonEntitlement"},
            custom => undefined
        },
        entitlementMapping => #{
            enabled => false,
            adminGroup => undefined,
            voGroupName => "embl",
            parser => flat_entitlement_parser,
            parserConfig => #{
                groupPrivilegesInVo => member,
                groupType => team,
                userPrivileges => member
            }
        }
    }
}}
```


### ESRF config (SAML)
```Erlang
{esrf, #{
    displayName => <<"ESRF (eduGAIN)">>,
    iconBackgroundColor => <<"#FFF">>,
    iconPath => <<"/assets/images/auth-providers/esrf.svg">>,
    protocol => saml,
    protocolConfig => #{
        metadataUrl => "https://met.refeds.org/met/entity/https%3A//websso.esrf.fr/auth/realms/ESRF/?viewxml=true",
        preferredSsoBinding => http_redirect,
        attributeMapping => #{
            subjectId => {required, "eduPersonTargetedID"},
            fullName => {optional, "displayName"},
            username => {optional, "eduPersonPrincipalName"},
            email => {optional, "mail"},
            entitlements => {optional, "eduPersonEntitlement"},
            custom => undefined
        },
        entitlementMapping => #{
            enabled => false,
            adminGroup => undefined,
            voGroupName => "esrf",
            parser => flat_entitlement_parser,
            parserConfig => #{
                groupPrivilegesInVo => member,
                groupType => team,
                userPrivileges => member
            }
        }
    }
}}
```


### IFAE config (SAML)
```Erlang
{ifae, #{
    displayName => <<"IFAE (eduGAIN)">>,
    iconBackgroundColor => <<"#FFF">>,
    iconPath => <<"/assets/images/auth-providers/ifae.jpg">>,
    protocol => saml,
    protocolConfig => #{
        metadataUrl => "https://met.refeds.org/met/entity/https%3A//www.rediris.es/sir/ifaeidp/?viewxml=true",
        preferredSsoBinding => http_redirect,
        attributeMapping => #{
            subjectId => {required, "eduPersonTargetedID"},
            fullName => {optional, "displayName"},
            username => {optional, "eduPersonPrincipalName"},
            email => {optional, "mail"},
            entitlements => {optional, "eduPersonEntitlement"},
            custom => undefined
        },
        entitlementMapping => #{
            enabled => false,
            adminGroup => undefined,
            voGroupName => "ifae",
            parser => flat_entitlement_parser,
            parserConfig => #{
                groupPrivilegesInVo => member,
                groupType => team,
                userPrivileges => member
            }
        }
    }
}}
```


### INFN config (SAML)
```Erlang
{infn, #{
    displayName => <<"INFN (eduGAIN)">>,
    iconBackgroundColor => <<"#FFF">>,
    iconPath => <<"/assets/images/auth-providers/infn.svg">>,
    protocol => saml,
    protocolConfig => #{
        metadataUrl => "https://idp.infn.it/saml2/idp/metadata.php",
        preferredSsoBinding => http_redirect,
        attributeMapping => #{
            subjectId => {required, "eduPersonTargetedID"},
            fullName => {optional, "displayName"},
            username => {optional, "eduPersonPrincipalName"},
            email => {optional, "mail"},
            entitlements => {optional, "eduPersonEntitlement"},
            custom => undefined
        },
        entitlementMapping => #{
            enabled => false,
            adminGroup => undefined,
            voGroupName => "infn",
            parser => flat_entitlement_parser,
            parserConfig => #{
                groupPrivilegesInVo => member,
                groupType => team,
                userPrivileges => member
            }
        }
    }
}}
```


### KIT config (SAML)
```Erlang
{kit, #{
    displayName => <<"KIT (eduGAIN)">>,
    iconBackgroundColor => <<"#FFF">>,
    iconPath => <<"/assets/images/auth-providers/kit.svg">>,
    protocol => saml,
    protocolConfig => #{
        metadataUrl => "https://met.refeds.org/met/entity/https%3A//idp.scc.kit.edu/idp/shibboleth/?viewxml=true",
        preferredSsoBinding => http_redirect,
        attributeMapping => #{
            subjectId => {required, "eduPersonPrincipalName"},
            fullName => {optional, "surName"},
            username => {optional, "eduPersonPrincipalName"},
            email => {optional, "mail"},
            entitlements => {optional, "eduPersonEntitlement"},
            custom => undefined
        },
        entitlementMapping => #{
            enabled => false,
            adminGroup => undefined,
            voGroupName => "kit",
            parser => flat_entitlement_parser,
            parserConfig => #{
                groupPrivilegesInVo => member,
                groupType => team,
                userPrivileges => member
            }
        }
    }
}}
```


### STFC config (SAML)
```Erlang
{stfc, #{
    displayName => <<"STFC (eduGAIN)">>,
    iconBackgroundColor => <<"#1C3764">>,
    iconPath => <<"/assets/images/auth-providers/stfc.svg">>,
    protocol => saml,
    protocolConfig => #{
        metadataUrl => "https://met.refeds.org/met/entity/https%3A//idp02.stfc.ac.uk/shibboleth/?viewxml=true",
        preferredSsoBinding => http_redirect,
        attributeMapping => #{
            subjectId => {required, "eduPersonTargetedID"},
            fullName => {optional, "displayName"},
            username => {optional, "eduPersonPrincipalName"},
            email => {optional, "mail"},
            entitlements => {optional, "eduPersonEntitlement"},
            custom => undefined
        },
        entitlementMapping => #{
            enabled => false,
            adminGroup => undefined,
            voGroupName => "stfc",
            parser => flat_entitlement_parser,
            parserConfig => #{
                groupPrivilegesInVo => member,
                groupType => team,
                userPrivileges => member
            }
        }
    }
}}
```


### SurfSara config (SAML)
```Erlang
{surfsara, #{
    displayName => <<"SURFSara (eduGAIN)">>,
    iconBackgroundColor => <<"#FFF">>,
    iconPath => <<"/assets/images/auth-providers/surfsara.png">>,
    protocol => saml,
    protocolConfig => #{
        metadataUrl => "https://technical.edugain.org/api.php?action=show_entity&row_id=27218",
        preferredSsoBinding => http_redirect,
        attributeMapping => #{
            subjectId => {required, "eduPersonTargetedID"},
            fullName => {optional, "displayName"},
            username => {optional, "eduPersonPrincipalName"},
            email => {optional, "mail"},
            entitlements => {optional, "eduPersonEntitlement"},
            custom => undefined
        },
        entitlementMapping => #{
            enabled => false,
            adminGroup => undefined,
            voGroupName => "surfsara",
            parser => flat_entitlement_parser,
            parserConfig => #{
                groupPrivilegesInVo => member,
                groupType => team,
                userPrivileges => member
            }
        }
    }
}}
```


### UnitedID config (SAML)
```Erlang
{unitedid, #{
    displayName => <<"UnitedID">>,
    iconBackgroundColor => <<"#ABDFF1">>,
    iconPath => <<"/assets/images/auth-providers/unitedid.png">>,
    protocol => saml,
    protocolConfig => #{
        metadataUrl => "http://md.unitedid.org/idp.xml",
        preferredSsoBinding => http_redirect,
        attributeMapping => #{
            subjectId => {required, "eduPersonTargetedID"},
            fullName => {optional, undefined},
            username => {optional, "eduPersonPrincipalName"},
            email => {optional, "eduPersonPrincipalName"},
            entitlements => {optional, undefined},
            custom => undefined
        },
        entitlementMapping => #{
            enabled => false,
            adminGroup => undefined,
            voGroupName => "unitedid",
            parser => flat_entitlement_parser,
            parserConfig => #{
                groupPrivilegesInVo => member,
                groupType => team,
                userPrivileges => member
            }
        }
    }
}}
```

