# Onedata firewall setup

Due to the fact that Onedata consists of several services which need to communicate between different sites, several ports need to be opened to the outside of the local network.

Below is a detailed list of ports, which need to be opened and their designation for both **Onezone** and **Oneprovider** services:

| Port     | Description                               |
| -------- | ----------------------------------------- |
| 53/TCP   | DNS (Required in Onezone)  |
| 53/UDP   | DNS (Required in Onezone)  |
| 80/TCP   | HTTP (Optional - automatically redirected to 443) |
| 443/TCP  | HTTPS, REST, Oneclient                    |
| 6665/TCP | Onedata data transfer channel (Oneprovider RTransfer) |
| 9443/TCP | Onepanel web interface (can be limited to local network) |

In **Onezone** service for the built-in DNS service to work additionally ports `53/TCP` and `53/UDP` should be opened.

For docker deployments, this implies following additionl port mappings should be added:

in **Onezone**:
```yaml
- "53:53"
- "53:53/udp"
- "80:80"
- "443:443"
- "9443:9443"
```

in **Oneprovider**:
```yaml
- "80:80"
- "443:443"
- "6665/TCP"
- "9443:9443"
```


Furthermore, on each Onedata deployment node where Couchbase database is installed, [these ports](https://developer.couchbase.com/documentation/server/3.x/admin/Install/install-networkPorts.html) must be available between the nodes (however they can be limited to the internal network).

Those ports correspond to additional mappings in docker compose:
```yaml
- "8092:8092"
- "11207:11207"
- "11209:11209"
- "11210:11210"
- "11211:11211"
- "18091-18092:18091-18092"
- "21100-21299:21100-21299"
```
