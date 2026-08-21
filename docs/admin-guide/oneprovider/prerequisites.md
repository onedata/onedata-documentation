# Prerequisites & requirements

This chapter describes the prerequisites and requirements that must be met before
deploying the Oneprovider service on any host, whether physical (bare metal) or virtual.

Follow the check-list below, making sure all points are adressed:

[toc][]

## Hardware & OS

All [installation methods][1] assume containerized deployments
(using Docker or Kubernetes). In principle, any Linux distribution can be used; however,
the recommended choice is Ubuntu 20.04 LTS or newer, as it has been thoroughly tested.

The host intended for a Oneprovider deployment must meet the following requirements:

| Requirement               | Minimum                      | Recommended baseline           | Comments                                                                                                                                                                            |
| ------------------------- | ---------------------------- | ------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| CPU                       | 4 vCPU                       | 16 vCPU                        | Scale proportionally with load. The recommended baseline corresponds to approximately 50-100 concurrent clients.                                                                    |
| RAM                       | 16 GB                        | 64 GB                          | Scale proportionally with load. The recommended baseline corresponds to approximately 50-100 concurrent clients.                                                                    |
| Root volume               | 30 GB                        | ≥ 60 GB <sup>1</sup>           | Space for files other than service persistence; container images, backups, dependencies, OS, etc.                                                                                   |
| Persistence volume        | 20 GB + 8 MB per 1,000 files | 100 GB + 10 MB per 1,000 files | The [host setup][2] assumes a separate block device for an LVM volume. Capacity depends primarily on the number of files (metadata and service data), not on the number of clients. |
| Disk type for persistence | SSD                          | High-speed SSD                 | The performance of the disk directly impacts the performance of the underlying database (Couchbase) and hence the service's ability to handle more concurrent requests.             |

<sup>1</sup>
If you plan to deploy the [OpenFaaS Engine][] for Automation on the
same machine, allow more disk space for docker-based Lambda images. For starters, consider
100 GB of extra disk capacity.

For an exemplary cloud-based deployment, one could create a Virtual Machine with
**Ubuntu 24.04**, **16 vCPU**, **64 GB RAM**, **60 GB root disk**, and
**200 GB empty block device** attached (but not mounted).

## Public IP and ports

Make sure your Oneprovider service will be reachable by the target audience:

* **Globally available via the Internet** — you will need **public external IP(s)**.
* **Available within an intranet** — you will need **IP(s)** reachable via the local routing.

Assigning the IP addresses:

* **Load balancer / reverse proxy / ingress** — the IP(s) should be assigned to the
  outward-facing network service, which then routes the traffic internally to Oneprovider host(s).
* **Direct routing** — the IP(s) should be assigned to the host(s).

The Oneprovider service exposes several ports. The table below will help you decide which
ones should be available publicly, or in a restricted manner. Make sure to configure your
firewall / security groups accordingly.

| Port | Typical setup                                        | Hardened setup                                                                 | Comments                                                                                                                                                                                                                                                                                                     |
| ---- | ---------------------------------------------------- | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 80   | Open publicly                                        | Closed if Let's Encrypt disabled                                               | This port is used for automated Let's Encrypt certificate generation and to automatically redirect clients from HTTP to HTTPS. In principle, it's not mandatory to be opened.                                                                                                                                |
| 443  | Open publicly                                        | Open within intranet or from whitelisted IPs/subnets                           | The main port (SSL-protected) for most Onedata clients and interfaces. Typically open to the Internet, unless it's required to limit access to certain addresses or networks.                                                                                                                                |
| 4443 | Open publicly                                        | Open within intranet or from whitelisted IPs/subnets, or closed if S3 disabled | The port (SSL-protected) hosting the S3 endpoint (OneS3 service) that emulates Onedata spaces as S3 buckets. May be closed if S3 is not required.                                                                                                                                                            |
| 6665 | Open publicly                                        | Accessible only by other Oneprovider services                                  | The port (SSL-protected) used for data transfers between providers. Typically open, but can be restricted to access strictly from the other Oneprovider hosts in the Onedata ecosystem.                                                                                                                      |
| 9443 | Open within intranet or from whitelisted IPs/subnets | Closed                                                                         | The port (SSL-protected) used for direct emergency access to the Oneprovider administration panel (Onepanel). Useful to manage the installation when the unified Onezone interface is not working correctly, but offers limited functions. Should be accessible only by admins, e.g. via organizational VPN. |

::: warning
We **strongly recommend closing all other ports** from public access for security.
Oneprovider runs some internal services on the host, including the Couchbase DB, or the
built-in Erlang daemon — EPMD. Exposing those for external access may create attack
vectors.
:::

## DNS domain

The host should be accessible via its FQDN. There are two scenarios for setting this up:

* supply your own FQDN, in which case your network administrator registers the domain and places the
  relevant DNS records,
* use the subdomain delegation feature of Onedata, which will generate an FQDN within the domain
  managed by the Onezone service.

## TLS certificate

Onedata services communicate with each other using the HTTPS protocol which require obtaining of TLS certificate
for the host. There are two ways to accomplish this:

* organizing the web cert by the administrator (it can be done both for non-delegated subdomain and
  delegated subdomain),
* using the Let's Encrypt (LE) service to obtain the web cert which also can be used for non-delegated subdomain and
  delegated subdomain.

::: tip NOTE
If you decide to use delegated subdomain and LE then the certificate management
happens automatically — it is covered by the Onedata software.
:::

## Systemd

Systemd should be installed on your system. This is the default for most modern Linux distributions. Oneprovider software uses systemd for
service management.

## Access to Onezone

You should have at least user-level access to existing Onezone instance before deploying
Oneprovider. In a common scenario, the Onezone instance has already been set up by your organization,
and you get access to it according to the organization's access policy. If you don't have such a possibility you can use
our Onezone service available at [demo.onedata.org][demo] (see the [user quickstart][] section for details).
Another possibility is deploying your own Onezone (see the [Onezone installation][] chapter).

## Host setup

The host should be initially configured before deploying the Oneprovider service. The available methods to do
this are described below.

### Using Ansible script

The **recommended way** is to use our proven Ansible script to set up your host.

Clone the repository on your host:

```sh
git clone https://github.com/onedata/onedata-deployments.git
cd onedata-deployments
```

Then, follow the instructions that can be found:

* in the repository: `./initial-vm-config/ansible/README.md`,
* or online: [README][initial-vm-config-ansible-readme].

### Manual preparation

Alternatively, you may perform the steps
[manually][initial-vm-config-manual-readme]
Note that the Oneprovider service is quite sensitive to the network settings and depends
on nuances well-captured by the Ansible playbook. Use the manual approach only as the last
resort.

<!-- references -->

[toc]: <>

[demo]: https://demo.onedata.org

[user quickstart]: ../../user-guide/quickstart.md

[onezone installation]: ../onezone/installation.md

[initial-vm-config-ansible-readme]: https://github.com/onedata/onedata-deployments/blob/master/initial-vm-config/ansible/README.md

[initial-vm-config-manual-readme]: https://github.com/onedata/onedata-deployments/blob/master/initial-vm-config/manual/README.md

[OpenFaaS Engine]: https://git.onedata.org/projects/VFS/repos/onedata-deployments/browse/openfaas

[1]: ./installation/overview.md

[2]: #host-setup
