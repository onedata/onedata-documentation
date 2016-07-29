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
|This certificate secures all HTTPS traffic for Web interface as well as REST and CDMI API's. The PEM file must contain the private key, public cert and trust chain all in a single file. |

| FUSE certificate |
|:-----------------|
| `/etc/op_worker/onedataServerFuse.pem` |
|This certificate secures communication between `onedata` command line client and the Oneprovider service. The PEM file must contain the private key, public cert and trust chain all in a single file. |

| FUSE CA certificate |
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


## Docker deployment
When deploying Onedata services using Docker, SSL certificates for Onedata services must be stored on the host machine where they will be accessible, relative to folder `/volumes/persistency` inside containers, i.e. a file that on a native system would be under path:

* `/etc/oz_worker/certs/gui_key.pem`

under Docker container must be available under:

* `/volumes/persistency/etc/oz_worker/certs/gui_key.pem`

Below is an example Docker compose file for Onezone service, which assumes that on the host machine, the following files are present at these locations:

* `/opt/onedata/onezone/auth.config` - Authentication configuration
* `/opt/onedata/onezone/ssl/etc/oz_worker/certs/gui_key.pem` - HTTP server private key
* `/opt/onedata/onezone/ssl/etc/oz_worker/certs/gui_cert.pem` - HTTP server public certificate
* `/opt/onedata/onezone/ssl/etc/oz_worker/certs/gui_cacert.pem` - CA certificate of the authority that signed the `gui_cert.pem`

```yaml
version: '2.0'

services:
  node1.onezone.onedata.example.com:
    image: onedata/onezone:3.0.0-beta8
    hostname: node1.onezone.onedata.example.com
    volumes:
        - /opt/onedata/onezone/auth.config:/volumes/persistency/var/lib/oz_worker/auth.config"
        - /opt/onedata/onezone/ssl:/volumes/persistency"
        - "/var/run/docker.sock:/var/run/docker.sock"
    ports:
      - "53:53"
      - "53:53/udp"
      - "443:443"
      - "80:80"
      - "5555:5555"
      - "5556:5556"
      - "6665:6665"
      - "6666:6666"
      - "7443:7443"
      - "8443:8443"
      - "8876:8876"
      - "8877:8877"
      - "9443:9443"
```
