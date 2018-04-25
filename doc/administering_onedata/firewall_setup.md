# Onedata firewall setup

Due to the fact that Onedata consists of several services which need to communicate between different sites, several ports need to be opened to the outside of the local network.

Below is a detailed list of ports, which need to be opened and their designation for both **Onezone** and **Oneprovider** services:

| Port     | Description                               |
| -------- | ----------------------------------------- |
| 53/TCP   | DNS (Optional - used for load-balancing)  |
| 53/UDP   | DNS (Optional - used for load-balancing)  |
| 80/TCP   | HTTP (Optional - automatically redirected to 443) |
| 443/TCP  | HTTPS, REST, Oneclient                    |
| 6665/TCP | Onedata data transfer channel (RTransfer) |
| 9443/TCP | Onepanel web interface (can be limited to local network) |


Furthermore, on each Onedata deployment node where Couchbase database is installed, [these ports](https://developer.couchbase.com/documentation/server/3.x/admin/Install/install-networkPorts.html) must be available between the nodes (however they can be limited to the internal network).


