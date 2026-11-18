<!-- @include admin-guide/administration-panel.md
  {
    "serviceUpper": "Onezone",
    "domain": "my.zone.domain.org",
    "features": "* installing Onezone using the [docker-compose][],\n* [managing certificates][],",
    "featureReferences": "[docker-compose]: ./installation.md\n\n[managing certificates]: ./configuration/web-certificate.md",
    "defaultAdminNote": "::: tip NOTE\nDo not confuse the `root` account with the `admin` user. A Onezone deployment\ncreates a special `admin` user whose password initially equals the Onezone\nemergency passphrase, but it can be changed independently. This is an ordinary\nOnezone user account with privileges assigned to it, unlike `root`, which is not a\nOnezone user. See\n[Administrative privileges](../administrative-privileges.md#the-default-admin-user) for details.\n:::\n\n",
    "screenshotDirectory": "../../../images/admin-guide/onezone/administration-panel"
  }
-->
