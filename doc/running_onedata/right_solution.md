# Picking the Right Solution

Onedata can run on a range of platforms, from VMs on a cloud provider, to rack of bare metal servers. The effort required to set up Onedata varies from running a single command to crafting your own customized Onedata clusters. We’ll guide you in picking a solution that fits for your needs.
If you just want to “kick the tires” on Onedata, we recommend the local Docker-based solution.

<!--The local Docker-based solution is one of several `Local cluster` solutions that are quick to set up, but are limited to running on one machine.
When you are ready to scale up to more machines and higher availability, a Hosted solution is the easiest to create and maintain.
Turn-key cloud solutions require only a few commands to create and cover a wider range of cloud providers.-->

Custom solutions require more effort to setup. If you are interested in setting your own custom Onedata installation please [contact us](onedata.orgl/support). 

<!---`onedata` but cover and even they vary from step-by-step instructions to general advice for setting up a Kubernetes cluster from scratch.
-->
<!--toc-->

## Local-machine Solutions

Local-machine solutions create a one or more clusters with one or more Onedata nodes on a single physical machine. Setup is completely automated and doesn’t require a cloud provider account. But their size and availability is limited to that of a single machine.
The local-machine solutions are:
- Local Docker-based (recommended starting point)
- No-VM local cluster (Linux only)
