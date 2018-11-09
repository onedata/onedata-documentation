# TLS certificate management

<!-- toc -->

All Onedata components require certain X.509 certificates to be installed in specific folders in order to properly handle TLS connections with clients.

Depending on the type of services which is being installed, Onepanel will look for certificates under the following paths:

- **Onezone**
  - `/etc/oz_panel/certs/web_key.pem`
  - `/etc/oz_panel/certs/web_cert.pem`
  - `/etc/oz_panel/certs/web_chain.pem` (optional)
  - `/etc/oz_panel/cacerts/*` (optional)

- **Oneprovider**
  - `/etc/op_panel/certs/web_key.pem`
  - `/etc/op_panel/certs/web_cert.pem`
  - `/etc/op_panel/certs/web_chain.pem` (optional)
  - `/etc/oz_panel/cacerts/*` (optional)

By default, **Onepanel** ships with dummy web certificates issued for `localhost`and signed by `OneDataTestWebServerCA`. It's enough to launch the service and access the gui by bypassing browser warnings. However, those test certificates will prevent Onezone-Oneprovider or inter-Oneprovider communication in a production environment and should never be used in such cases.
Communication using those test certificates can be enabled for test purposes by setting `ONEPANEL_TRUST_TEST_CA` environment variable during cluster deployment.

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
Both **Oneprovider** and **Onezone** support obtaining web certificates
automatically via Let’s Encrypt. This feature can be enabled in **Onepanel**
GUI, via REST or by passing `letsEncryptEnabled` flag in Docker Compose
configuring the cluster.

Please note that Let's Encrypt imposes limits on certificates generated for
each domain in a period of one week, so the automatic generation might fail
temporarily in some cases. This is especially important in **Oneproviders**
using __subdomain delegation__, as the limit is global for the **Onezone**'s
domain.

> NOTE: When deploying via GUI using this feature, your web browser will need
to reload the page when new certificates are installed.

## Let's Encrypt in private networks
When registering **Oneproviders** using the __subdomain delegation__ feature,
it is possible to use Let's Encrypt client even if **Oneprovider** is
deployed on host not accessible from the public Internet. In this scenario
only the **Onezone** needs to work in a public domain in order to support
validating its subdomains in Let's Encrypt. In this case the DNS method of
the Let's Encrypt authorization is used, requires the Onezone domain to be
[delegated (see docs)](./onezone_tutorial.md#dns-records-setup-for-subdomain-delegation) at
its DNS registrar.

## Docker deployment

When deploying **Onedata** services using Docker, TLS certificates for
Onedata services must be mounted from the host to the appropriate paths in
the Docker container, for example when using Docker Compose, this can be
achieved using the following configuration:

```yaml
version: '2.0'
services:
  node1.oneprovider:
    image: onedata/oneprovider:18.02.0
    hostname: node1.oneprovider.
    container_name: oneprovider-1
    volumes:
        - "/etc/letsencrypt/live/oneprovider-example.com/privkey.pem:/etc/op_panel/certs/web_key.pem"
        - "/etc/letsencrypt/live/oneprovider-example.com/cert.pem:/etc/op_panel/certs/web_cert.pem"
        - "/etc/letsencrypt/live/oneprovider-example.com/fullchain.pem:/etc/op_panel/certs/web_chain.pem"
        ...

```

