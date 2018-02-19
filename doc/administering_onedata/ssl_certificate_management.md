# TLS certificate management

<!-- toc -->

All Onedata components require certain X.509 certificates to be installed in specific folders in order to properly handle TLS connections with clients.

Depending on the type of services which is being installed, Onepanel will look for certificates under the following paths:

- **Onezone**

- - `/etc/oz_panel/certs/web_key.pem`
  - `/etc/oz_panel/certs/web_cert.pem`
  - `/etc/oz_panel/certs/web_chain.pem` (optional)
  - `/etc/oz_panel/cacerts/*` (optional)

- **Oneprovider**

- - `/etc/op_panel/certs/web_key.pem`
  - `/etc/op_panel/certs/web_cert.pem`
  - `/etc/op_panel/certs/web_chain.pem` (optional)
  - `/etc/oz_panel/cacerts/*` (optional)

By default, **Onepanel** ships with dummy web certificates issued for `localhost`and signed by `OnedataTestCa`. There is no need to change anything if you are just testing and do not care about the browser connection to be secure. However, you must not use those certificates in production.

## Onezone

| Web Server private key                   |
| :--------------------------------------- |
| `/etc/oz_panel/certs/web_key.pem`        |
| This is the private key of the TLS certificate for Onezone service for securing the HTTPS traffic. |

| Web Server public certificate            |
| :--------------------------------------- |
| `/etc/oz_panel/certs/web_cert.pem`       |
| This is the public key of the TLS certificate for Onezone service for securing the HTTPS traffic. |

| Web Server CA certificate                |
| :--------------------------------------- |
| `/etc/oz_panel/certs/web_chain.pem`      |
| This is the CA chain for the web certificate. It’s optional (omitted if the file does not exists) - there is no need to provide it if your web certificate was signed by a well-known, trusted root CA. |

| Trusted CA certificates                  |
| ---------------------------------------- |
| `/etc/oz_panel/cacerts/*`                |
| This directory is used to add trusted certificates to Onezone. By default, a standard CA bundle is used, so in most cases there is no need to add additional certificates. If your environment uses its own certification, you should add your trusted CA’s here.  To add certificates, just place files in this directory. Each file can contain any number of certificates. The application will read the whole directory, no matter what the file names actually are. This directory is NOT used to add trusted chain to your web certificate, in such case please see the Web Server CA certificate section. |

## Oneprovider

| Web Server private key                   |
| :--------------------------------------- |
| `/etc/op_panel/certs/web_key.pem`        |
| This is the private key of the TLS certificate for Oneprovider service for securing the HTTPS traffic. |

| Web Server public certificate            |
| :--------------------------------------- |
| `/etc/op_panel/certs/web_cert.pem`       |
| This is the public key of the TLS certificate for Oneprovider service for securing the HTTPS traffic. |

| Web Server CA certificate                |
| :--------------------------------------- |
| `/etc/op_panel/certs/web_chain.pem`      |
| This is the CA chain for the web certificate. It’s optional (omitted if the file does not exists) - there is no need to provide it if your web certificate was signed by a well-known, trusted root CA. |

| Trusted CA certificates                  |
| ---------------------------------------- |
| `/etc/op_panel/cacerts/*`                |
| This directory is used to add trusted certificates to Oneprovider. By default, a standard CA bundle is used, so in most cases there is no need to add additional certificates. If your environment uses its own certification, you should add your trusted CA’s here.  To add certificates, just place files in this directory. Each file can contain any number of certificates. The application will read the whole directory, no matter what the file names actually are. This directory is NOT used to add trusted chain to your web certificate, in such case please see the Web Server CA certificate section. |

## Let’s Encrypt support

**Oneprovider** supports obtaining web certificates automatically via Let’s Encrypt, given that subdomain delegation [tu link do sekcji subdomain delegation] is enabled. This option can be enabled both during deployment via GUI or in batch mode.

Please note that **Onezone** is subject to limits imposed by Let’s Encrypt, so the automatic generation might not always be possible, in case the limits are reached.

> NOTE: When deploying via GUI using this feature, your web browser will need to reload the page when new certificates are installed.



## Docker deployment

When deploying **Onedata** services using Docker, TLS certificates for Onedata services must be mounted from the host to the appropriate paths in the Docker container, for example when using Docker Compose, this can be achieved using the following configuration:

```yaml
version: '2.0'
services:
  node1.oneprovider:
    image: onedata/oneprovider:18.02.0
    hostname: node1.oneprovider.
    container_name: oneprovider-1
    volumes:
        - "/etc/letsencrypt/live/onedata-test-02.tk/privkey.pem:/etc/op_panel/certs/web_key.pem"
        - "/etc/letsencrypt/live/onedata-test-02.tk/cert.pem:/etc/op_panel/certs/web_cert.pem"
        - "/etc/letsencrypt/live/onedata-test-02.tk/fullchain.pem:/etc/op_panel/certs/web_chain.pem"
        ...

```

