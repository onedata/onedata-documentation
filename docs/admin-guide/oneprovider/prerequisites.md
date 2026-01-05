# Prerequisites & requirements

This chapter describes the prerequisites and requirements which should be met before deploying the Oneprovider service.

## Hardware & OS

The node on which Oneprovider will be deployed should fulfill the requirements shown in the table below.

| Requirement               | Minimum                          | Optimal                          |
| ------------------------- | -------------------------------- | -------------------------------- |
| CPU                       | 4 vCPU                           | 16 vCPU                          |
| RAM                       | 16 GB                            | 64 GB                            |
| Root disk                 | SSD (25 GB)                      | SSD (50 GB)                      |
| Disk for Onedata software | 20 GB + 8 MB for each 1000 files | 40 GB + 8 MB for each 1000 files |
| Operating system          | Ubuntu 20.04 or later                                               |

## Public IP and ports

The node should have a network interface with public IP. Oneprovider communicates with external services or clients
using ports 80, 443, 4443, 6665 and 9443. All of these ports need to be publicly open, except 9443, which is used for
direct emergency access to the Oneprovider.

::: warning
We strongly recommend closing all other ports from public access for security. Oneprovider
runs some internal services on the host, including the Couchbase DB, or the built-in
Erlang daemon — EPMD. Exposing those for external access may create attack vectors.
:::

## DNS domain

The node should be accessible via its FQDN. There are two scenarios for setting this up:

* supply your own FQDN, in which case your network administrator registers the domain and places the
  relevant DNS records,
* use the subdomain delegation feature of Onedata, which will generate an FQDN within the domain
  managed by the Onezone service.

## TLS certificate

Onedata services communicate with each other using the HTTPS protocol which require obtaining of TLS certificate
for the node. There are two ways to accomplish this:

* organizing the web cert by the administrator (it can be done both for non-delegated subdomain and
  delegated subdomain),
* using the Let's Encrypt (LE) service to obtain the web cert which also can be used for non-delegated subdomain and
  delegated subdomain.

::: tip NOTE
If you decide to use delegated subdomain and LE then the certificate management
happens automatically — it is covered by the Onedata software.
:::

## Access to Onezone

You should have at least user-level access to existing Onezone instance before deploying
Oneprovider. In a common scenario, the Onezone instance has already been set up by your organization,
and you get access to it according to the organization's access policy. If you don't have such a possibility you can use
our Onezone service available at [demo.onedata.org][demo] (see the [user quickstart][] section for details).
Another possibility is deploying your own Onezone (see the [Onezone installation][] chapter).

## Node setup

The node should be initially configured before deploying the Oneprovider service. The available methods to do
this are described below.

### Using Ansible script

The **recommended way** is to use our proven Ansible script to set up your node.

Clone the repository on your node:

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

[demo]: https://demo.onedata.org

[user quickstart]: ../../user-guide/quickstart.md

[onezone installation]: ../onezone/installation.md

[initial-vm-config-ansible-readme]: https://github.com/onedata/onedata-deployments/blob/master/initial-vm-config/ansible/README.md

[initial-vm-config-manual-readme]: https://github.com/onedata/onedata-deployments/blob/master/initial-vm-config/manual/README.md

