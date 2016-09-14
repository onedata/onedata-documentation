# SSL certificate management

All Onedata components require certain X.509 certificates to be installed in specific folders in order to properly handle TLS connections with clients.

The following sections detail certificates required by each Onedata service.

Whenever certificates for given service change, the service must be restarted.

## Onezone

| Web Server private key |
|:-----------------|
| `/etc/op_panel/certs/key.pem"` |
| This is the private key of the certificate for Onezone service for securing the HTTPS traffic. |

| Web Server public certificate |
|:-----------------|
| `/etc/op_panel/certs/cert.pem` |
| This is the public certificate for Onezone service for securing the HTTPS traffic. |

| Web Server CA certificate |
|:-----------------|
| `/etc/op_panel/certs/cacert.pem` |
| This is the certificate of the CA authority used for signing Onezone certificates. |

## Oneprovider

| Web Server private key |
|:-----------------|
| `/etc/oz_panel/certs/key.pem"` |
| This is the private key of the certificate for Oneprovider service for securing the HTTPS traffic. |

| Web Server public certificate |
|:-----------------|
| `/etc/oz_panel/certs/cert.pem` |
| This is the public certificate for Oneprovider service for securing the HTTPS traffic. |

| Web Server CA certificate |
|:-----------------|
| `/etc/oz_panel/certs/cacert.pem` |
| This is the certificate of the CA authority used for signing Oneprovider certificates. |

## Docker deployment
When deploying Onedata services using Docker, SSL certificates for Onedata services must be stored on the host machine where they will be accessible, relative to folder `/volumes/persistence` inside containers, i.e. a file that on a native system would be under path:

* `/etc/oz_panel/certs/key.pem`

under Docker container must be available under:

* `/volumes/persistence/etc/oz_worker/certs/gui_key.pem`

For examples of configuration that include certificates please refer to [getting-started](https://github.com/onedata/getting-started) github repository, where you will find multiple *docker-compose.yml* configuration files using then. 