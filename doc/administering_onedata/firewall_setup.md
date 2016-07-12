# Onedata Firewall setup

Due to the fact that Onedata consists of several services which need to communicate between different sites, several ports need to be opened to the outside of the local network.

Below is a detailed list of ports which need to be opened and their designation:

| Port      |  Description |
|-----------|--------------|
| 53/TCP    |  DNS    |
| 53/UDP    |  DNS    |
| 80/TCP    | HTTP    |
| 443/TCP   | HTTPS   |
| 5555/TCP  | Communication between Oneclient command line tool and Oneprovider service (TCP) |
| 5556/TCP  | Communication between Oneprovider services among different sites |
| 6665/TCP  | Onedata data transfer channel (RTransfer) |
| 6666/TCP  | Onedata data transfer channel (RTransfer) |
| 7443/TCP  | Communication between Oneprovider instances and Onezone used to exchange metadata  |
| 8443/TCP  | REST and CDMI API's  (HTTP) |
| 8876/TCP  | RTransfer protocol gateway |
| 8877/TCP  | RTransfer protocol gateway |
| 9443/TCP  | Onepanel web interface |


Onezone service provides 2 REST operations for testing whether all the ports in a given deployment are properly opened, and can be used as follows.

First query returns the actual IP of the host from which query was initiated, can be used to check if any NAT translation takes place between the host and Onezone service:
```bash
curl -X GET -H "macaroon: $(ACCESS_TOKEN)" \
https://$(ONEZONE_HOST):8443/api/v3/onezone/test/check_my_ip
```

The second test checks whether all ports of all Oneprovider instances registered in the Onezone are are properly opened:
```bash
curl -X GET -H "macaroon: $(ACCESS_TOKEN)" \
https://$(ONEZONE_HOST):8443/api/v3/onezone/test/check_my_ports
```
which should return the list of Oneprovider hosts and ports combinations with their status, e.g.:
```
[
    {'oneprovider1.example.com:80', 'ok'},
    {'oneprovider1.example.com:443', 'ok'},
    {'oneprovider1.example.com:53', 'error'},
    {'oneprovider2.example.com:80', 'ok'},
    {'oneprovider2.example.com:443', 'error'},
    {'oneprovider2.example.com:53', 'error'}
]
```

These operations require the user to have `list_providers` privilege.

