# OpenID & SAML Configuration

OpenID and SAML are the main authentication methods used in Onedata. 
They allow users to reuse their accounts from other websites such as social 
networks or infrastructure portals.

The OIDC/SAML configuration has changed throughout the releases.
Please choose your current Onezone version and remember to consult this 
documentation when planning an upgrade. Important changes are mentioned at
the top of every page:

* [18.02.0-rc11 or older](./openid_saml_configuration/openid_configuration_legacy.md)
* [18.02.0-rc12 - 18.02.*](./openid_saml_configuration/openid_saml_configuration_18_02.md)
* [19.02.* or newer](./openid_saml_configuration/openid_saml_configuration_19_02.md)


### Automatic config upgrade

During the first startup after upgrading Onezone to a newer version, Onezone will 
attempt to automatically upgrade the config file to the latest version. 
In such case, the old config file (`auth.config`) will be backed up to 
`auth.config.v{vsn}.bak`. Information whether the upgrade was successful will be 
present in [Onezone logs](./onezone_tutorial.md#logs). Please always examine the 
upgraded `auth.config` file to make sure that it was correctly converted.
