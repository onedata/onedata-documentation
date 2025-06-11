# Troubleshooting

## Connectivity issues

**@insert serviceUpper** service requires several TCP ports (`80`, `443`, `6665`, `9443`)
to be opened for proper operation. Some of these ports can be limited to
an intranet, in particular `9443` for Onepanel management interface.

In a multi-node deployment scenario, you need to expose certain additional
ports on all nodes where the Couchbase instance is deployed:

* 8091 — Couchbase admin interface (Optional)
* 8092
* 11207
* 11209
* 11210
* 11211
* 18091-18092
* 21100-21299

::: danger SECURITY RISK
Exposing these ports to the public internet can pose a significant security risk.
Ensure that these ports are only accessible within the intranet to maintain
the integrity and security of your Couchbase deployment.
:::

For more information about ports setup, see [Firewall setup][].