# SSL certificate management

<!-- toc -->

All Onedata components require certain X.509 certificates to be installed in specific folders in order to properly handle TLS connections with clients.

The following sections detail certificates required by each Onedata service.

Whenever certificates for given service change, the service must be restarted.

The certificates should be accessible to the Onepanel administration service before deploying particular Onedata service, i.e.: Onezone or Oneprovider. Depending on the type of services which is being installed, Onepanel will for certificates under the following paths:
* Onezone - `/etc/oz_panel/certs`
* Oneprovider - `/etc/op_panel/certs`

Each service requires specific certificate and key files, as explained below.

## Onezone

| Web Server private key |
|:-----------------|
| `/etc/oz_panel/certs/key.pem"` |
| This is the private key of the certificate for Onezone service for securing the HTTPS traffic. |

| Web Server public certificate |
|:-----------------|
| `/etc/oz_panel/certs/cert.pem` |
| This is the public certificate for Onezone service for securing the HTTPS traffic. |

| Web Server CA certificate |
|:-----------------|
| `/etc/oz_panel/certs/cacert.pem` |
| This is the certificate of the CA authority used for signing Onezone certificates. |

## Oneprovider

| Web Server private key |
|:-----------------|
| `/etc/op_panel/certs/key.pem"` |
| This is the private key of the certificate for Oneprovider service for securing the HTTPS traffic. |

| Web Server public certificate |
|:-----------------|
| `/etc/op_panel/certs/cert.pem` |
| This is the public certificate for Oneprovider service for securing the HTTPS traffic. |

| Web Server CA certificate |
|:-----------------|
| `/etc/op_panel/certs/cacert.pem` |
| This is the certificate of the CA authority used for signing Oneprovider certificates. |


## Docker deployment
When deploying Onedata services using Docker, SSL certificates for Onedata services must be stored on the host machine where they will be accessible, relative to folder `/volumes/persistence` inside containers, i.e. a file that on a Onedata installation deployed using packages would be under path:

* `/etc/oz_panel/certs/key.pem`

under Docker container must be available under:

* `/volumes/persistence/etc/oz_worker/certs/gui_key.pem`

For examples of configuration that include certificates please refer to [getting-started](https://github.com/onedata/getting-started) GitHub repository, where you can find multiple *docker-compose.yml* configuration files using them. 
