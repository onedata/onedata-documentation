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
| `/var/lib/op_panel/certs/server.crt` and `/var/lib/oz_panel/certs/server.crt` |
| Keys used by Oneprovider and Onezone service respectively. |


