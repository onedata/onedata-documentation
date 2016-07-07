# Load balancing

Onedata implements a very scalable load balancing solution based on DNS protocol, which can be leveraged in order to scale Onedata services within a local site or federation of sites.

## Algorithm
Onedata uses a Two-Level Load Balancing (TLLB) scheme, whose goal is to supporting adaptation to various kinds of load issues, including:
* peak loads
* unbalanced use of resources
* node failures

The used TLLB algorithm relies on 2 components: DNS servers and dispatchers, however both these components are integrated directly into Onedata components deployed in the local site, so no additional services don't need to be started.

### DNS servers
In a typical scenario, user tries to connect to a Onedata service either from a public network or a local network using some domain name address, e.g. (onedata.example.com). After getting the public DNS record for Onedata service in this site, another DNS query to that IP address will return a DNS record with all Onedata nodes in this site.
Each DNS response returns the list of IP addresses of nodes sorted in the order of increasing load, i.e. the nodes with least load are returned at the beginning of the list.
This approach is fine for most clients, which tend to select the first record returned by DNS.

### Dispatchers
On the second level, dispatcher components allow for custom heuristics to be applied to the load balancing algorithm. The dispatcher rules are controlled by specifying coefficients of an equation which depends on current CPU load and memory usage.

## Configuration

The configuration of the load balancing can be achieved by modifying the `dns.config` file on the Onezone service node, normally located in `/var/lib/oz_worker/dns.config`.

An example file is presented below:
```erlang
% Zone definition for oz_worker DNS server
{zone, [
    % Canonical domain name
    {cname, "onedata.org"},
    % IP addresses of servers in the domain (list of IPs for every hostname).
    % "ALL" is resolved as all GR worker ips.
    % Must include NS and MX servers.
    % All hostnames must end with cname.
    {ip_addresses, [
        {"onedata.org", ["ALL"]},
        {"ns.onedata.org", ["ALL"]},
        {"mail.onedata.org", ["127.0.0.1"]}
    ]},
    % Hostnames of domain's name servers
    {ns_servers, [
        "ns.onedata.org"
    ]},
    % Hosts handling mail exchange for the domain
    {mail_exchange, [
        % Values are {<preference>, <hostname>}, lowest preference is preferred
        {10, "mail.onedata.org"}
    ]},
    % Parameters used to generate SOA responses
    {authority, [
        % Primary nameserver hostname
        {primary_ns, "ns.onedata.org"},
        % Nameserver admin mailbox
        {admin_mailbox, "dns-admin.onedata.org"},
        % This value must be incremented on every update of this config file
        {serial, 2014111200},
        % Time interval before the zone should be refreshed
        {refresh, 7200}, 
        % Time interval that should elapse before a failed refresh should be retried
        {retry, 1800},
        % Time value that specifies the upper limit on the time interval that 
        % can elapse before the zone is no longer authoritative
        {expiry, 1209600},
        % Time a NAME ERROR = NXDOMAIN result may be cached by any resolver
        {nxdomain_ttl, 120}
    ]},
    % Time To Live for defferent types of responses
    {ttl, [
        {a, 120},
        {ns, 120},
        {soa, 120},
        {mx, 120},
        % Used when answering that a certain oneprovider supports requested domain.
        % For example: Question A alias.onedata.org will be answered with oneprovider IP in authority section with this TTL.
        {oneprovider_ns, 120},
        % Analogical as above, but corcerns a case when GR answers with A records so that the provider does not have
        % to host a DNS server. This feature can be turned on during installation.
        {oneprovider_a, 120}
    ]}
]}.
```


