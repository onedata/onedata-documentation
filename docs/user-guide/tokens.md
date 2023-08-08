# Tokens

[toc][1]

## Quickstart

See the [GUI guide][2] for examples how to quickly obtain basic tokens
and consume invite tokens.

## Basics

A token is an alphanumeric string acting as a proof of authorization that can be
used across the system.

There are three types of tokens in Onedata: [access tokens][3],
[identity tokens][4] and [invite tokens][5].

Regardless of the above-mentioned type, each token can be
[named or temporary][6].

Tokens are passed around the system in a serialized form — an alphanumeric
string that looks like the following:
`MDAxNWxvY2F00aW9uIG9uZXpvbmUKMDAzYmlkZW500aWZpZXIgRHR00WTg5dH...`

The implementation of tokens in Onedata is based on [Google's macaroons][] and utilizes
their fundamental concept of [caveats][7] — contextual confinements.

All tokens are created in Onezone and can only be verified by Onezone.

Tokens can be created and managed using the [wizard][2] in Onezone web
GUI or the [REST API][8].

In general, **tokens must be kept secret**. It is possible to strongly confine a
token with proper caveats and make it safe to be [passed to another party or
published][9], but it must be done with great care.

## Access tokens

Access tokens are the basic way to authorize operations in Onedata — either in
REST/CDMI API or when mounting Oneclient. Access tokens are a type of bearer
authentication, which means that the party in possession of a token can use it
to perform operations on behalf of the token subject (creator). The subject can
be either a user or a Oneprovider service. For clarity, this documentation talks
about user tokens, but all the aspects are symmetrical for Oneproviders.

Access tokens are tied to the subject that created the token. From the system's
point of view, the token bearer is indistinguishable from the subject. Consider
this example:

1. Bob creates a token and gives it to Alice

2. Alice uses the token to authorize a request

3. The system identifies the requesting subject as Bob, authorizes and handles
   the request in this context, operating on Bob's data. It does not matter if
   the requesting client (token bearer) was Alice or Bob.

Access tokens carry authorization to perform operations in the system on behalf
of the subject. The authorization can be limited by [caveats][7].

> **NOTE**: If there are no caveats, the token carries **absolute power to
> perform any operation** on behalf of the subject – similar to user's password.
> Users are strongly recommended **NOT** to create such tokens, as there is always
> a risk of a token being intercepted by a malicious party.

Authorization in Onedata depends on the token's subject, their relations and
privileges (e.g. space membership and the privileges in the space), as well as
token's caveats. For example, for Bob to be able to create a file in space
`My experiment`, all below requirements need to be satisfied:

1. Bob must be a member of the space `My experiment`

2. Bob must have `space_write_data` privilege in space `My experiment`

3. Requesting party must present a valid token with `subject = Bob`

4. The access token must allow writing in space `My experiment`
   (or to be accurate, token caveats must not forbid writing in the space)

Access tokens are a powerful tool for authority delegation, but at the same time
require caution – they must be kept secret, similarly to user passwords. However,
thanks to support for [caveats][7] (contextual confinements),
tokens can be limited with fine granularity, making it safer to delegate them to
other users or services. Nevertheless, you should never disclose your tokens to
a party that is not trusted.

## Identity tokens

Identity tokens are a proof of subject's identity. Other than that, they carry
no authorization to perform any operation in the system. Proving identity with
an identity token is required to satisfy a [`consumer` caveat][10] in
another token. An identity token can have [caveats][7], which limit
the context in which the token is accepted (e.g. shortlisting the allowed IP
addresses from which the token can be used).

> Identity tokens must not be disclosed to other users or untrusted services,
> as whoever possesses such token can impersonate the subject. They can be safely
> sent to the **Onezone** service. When using such token in a **Oneprovider**
> service, it is strongly recommended to add a short TTL for the token with a
> [`time` caveat][7].

## Invite tokens

Invite tokens in Onedata are used to create relations in the system. They can be
consumed by anyone who possesses the token (unless the token has a
[`consumer` caveat][10]). Typical scenario is that the inviting
user (token subject) generates a token and passes it to somebody that they wish
to invite, and the other user consumes the token and is added to the target
entity (e.g. group or space).

Each token has inscribed information about the target entity of the invitation
which is chosen by the inviting user. It means that the token consumer does not
choose where they are joining and does not need to know the target group, space
etc. beforehand – the token itself is enough to join it.

The [Onezone Web GUI][2] provides a comprehensive wizard for creating
invite tokens with different parameters. Below is some technical information about
the invite tokens which might be useful for [REST API][8] users.

Invite tokens can have one of the following types, determining the action
applied when the token is consumed:

* `userJoinGroup` - join the target group of the invitation as a user

* `groupJoinGroup` - join the target group (parent) of the invitation as a group (child)

* `userJoinSpace` - join the target space of the invitation as a user

* `groupJoinSpace` - join the target space of the invitation as a group

* `supportSpace` - grant support (storage space) to the target space of the
  invitation (consumed by a Oneprovider)

* `harvesterJoinSpace` - join the target space of the invitation as a harvester,
  so that the space becomes a metadata source for the harvester.

* `registerOneprovider` - register a new Oneprovider and link it to the target
  user (who becomes an admin of the Oneprovider service)

* `userJoinCluster` - join the target cluster of the invitation as a user

* `groupJoinCluster` - join the target cluster of the invitation as a group

* `userJoinHarvester` - join the target harvester of the invitation as a user

* `groupJoinHarvester` - join the target harvester of the invitation as a group

* `spaceJoinHarvester` - join the target harvester of the invitation as a space,
  so that the space becomes a metadata source for the harvester.

Invite tokens can be created by authorized users, for example a `userJoinSpace`
token can be created by a member of the target space that has the
`space_add_user` privilege. The privilege is also checked when the token is
being consumed - if the creator has lost the right to invite, the token cannot
be consumed.

An invite token can have [caveats][7], which limit the context in
which the token can be consumed.

[Named][6] invite tokens can have additional parameters,
which are optional:

1. Carried privileges (if applicable) - defines what privileges will be granted
   for the joining member upon token consumption. If not specified, default
   member privileges will be granted.

2. Usage limit - defines how many times the token can be used. If not specified,
   there is no limit.

## Named and temporary tokens

Tokens in Onedata can be temporary or named, regardless of the type (access,
invite or identity). Temporary tokens are short lived and not persisted, while
named tokens are linked to user's account and retrievable. All differences are
shown in below table.

| Temporary tokens                                                                                                                   | Named tokens                                                                                |
| ---------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| no identification in the system                                                                                                    | must have a unique name                                                                     |
| not persisted                                                                                                                      | persisted                                                                                   |
| cannot be retrieved <br/> <sub style="color: #06f;">you must store the token upon creation</sub>                                   | linked to subject's account                                                                 |
| shared secret <br/><sub style="color: #06f;">the secret can be regenerated, which invalidates all subject's temporary tokens</sub> | individual secret                                                                           |
| cannot be deleted individually <br/><sub style="color: #06f;">see shared secret above</sub>                                        | can be deleted <br/><sub style="color: #06f;">(the token immediately becomes invalid)</sub> |
| non-revocable individually <br/><sub style="color: #06f;">see shared secret above</sub>                                            | revocable <br/><sub style="color: #06f;">revocation can be undone at will</sub>             |
| must have limited lifespan <br/><sub style="color: #06f;">max permitted lifespan is configurable by the Onezone admin</sub>        | can have infinite lifespan                                                                  |
| no accounting, cannot be listed                                                                                                    | can be listed in [REST API][8] or viewed in [WEB GUI][2]                                    |
| useful for automated software / middleware / scripting                                                                             | require more management but ensure full control                                             |

## Token caveats

Each token can have any number of caveats (including none). Caveats are a
fundamental concept of [Google's macaroons][] (which are used for token
implementation in Onedata). Caveats are contextual confinements - they limit the
context in which a token is valid. They are inscribed in the token itself,
which enables powerful delegation features. Thanks to cryptographic signatures,
caveats cannot be removed from a token. However, they can be added to any token
by any party that possesses the token. Such operation further limits the token,
making it carry less power that the original one. The limited token can be
safely passed to another party, which won't be able to overcome the limitations
without knowing the original token. Consider this example:

1. Bob creates a named token `Alpha` for accessing his data, but only in the
   space `My experiment` - using the `data.path` caveat.

2. Bob confines the token `Alpha` - adds the `data.readonly` caveat - and
   obtains token `Alpha*` with different signature.

3. Bob passes the token `Alpha*` to Alice. Alice is able to read the space
   `My experiment`, but cannot modify any files. The space is accessed on
   behalf of Bob - from the system's point of view, whoever bears the token is
   recognized as Bob. Cryptography ensures that it is computationally
   implausible to infer token `Alpha` knowing only `Alpha*`. If Bob wishes to
   publish his experiment data online, he can safely make the token `Alpha*`
   public (see [safely publishing tokens][9]) - nobody
   will be able to use it in other way than to read the `My experiment` data.
   Bob can temporarily revoke or completely delete the token `Alpha` at any
   time, which will immediately disable the original token `Alpha` and all
   tokens derived from it - including the published `Alpha*` token.

4. In the meantime, Bob still uses the original token `Alpha` to write data in
   the `My experiment` space, which becomes immediately visible for the users
   that have the `Alpha*` token.

The [Onezone Web GUI][2] offers a convenient wizard for adding caveats to
tokens. Further, you will find technical details and considerations about token caveats.

Below is the list of all recognized caveats in Onedata. Provided examples of
caveats are in JSON format, recognized by the [REST API][8]
(consult for more information about allowed values and usage).

* `time` - limits the validity of the token to a certain point in time,
  specified as an absolute timestamp in seconds (UNIX Epoch time). If no such
  caveat is included in a token, it is valid infinitely. Note, however, that
  temporary tokens **require** a time caveat, contrary to named tokens.
  ```json
  {
    "type": "time",
    "validUntil": 1571147494
  }
  ```

* `ip` - limits the allowed client IPs to a certain whitelist. Supports IP
  masks. If no such caveat is included in a token, it can be used from any IP.
  ```json
  {
      "type": "ip",
      "whitelist": [
          "189.34.15.0/24",
          "127.0.0.0/8",
          "167.73.12.17"
      ]
  }
  ```
  > NOTE: when adding `ip` caveats, keep in mind that if your requests need to
  > be proxied to another Oneprovider, the IP of the Oneprovider that received
  > the original request must also be whitelisted (as it is perceived as the
  > new request's client). Proxying happens when the Oneprovider that received
  > your request does not support the concerned space.

* `asn` - limits the ASNs (Autonomous System Number) from which the token can be
  utilized. The client's ASN is resolved based on client's IP and MaxMind's
  GeoLite database. If no such caveat is included in a token, it can be used
  from any ASN.
  ```json
  {
      "type": "asn",
      "whitelist": [
          631, 632, 1671
      ]
  }
  ```
  > NOTE: as the client ASN detection depends on client's IP, this caveat
  > has the same considerations as the `ip` caveat when requests are proxied.

* `geo.country` - limits the countries from which the token can be utilized.
  Supports whitelists and blacklist. The client's country is resolved based on
  client's IP and MaxMind's GeoLite database. If no such caveat is included in
  a token, it can be used from any country.
  ```json
  {
      "type": "geo.country",
      "filter": "blacklist",
      "list": [
        "PL", "UK", "DE", "NL"
      ]
  }
  ```
  > NOTE: as the client country detection depends on client's IP, this caveat
  > has the same considerations as the `ip` caveat when requests are proxied.

* `geo.region` - limits the geographical regions from which the token can be
  utilized. The available values are the 7 continents (`"Oceania"` covers
  Australia and the pacific islands) or the `"EU"` meta region, which matches
  member countries of the European Union. The client's region is resolved
  based on client's IP and MaxMind's GeoLite database. If no such caveat is
  included in a token, it can be used from any region.
  ```json
  {
      "type": "geo.region",
      "filter": "whitelist",
      "list": [
          "Africa",
          "Antarctica",
          "Asia",
          "EU",
          "Europe",
          "NorthAmerica",
          "Oceania",
          "SouthAmerica"
      ]
  }
  ```
  > NOTE: as the client region detection depends on client's IP, this caveat
  > has the same considerations as the `ip` caveat when requests are proxied.

* `service` - limits the [services][11] that can process the token. Imposes
  implicit [API limitations][12]. If the caveat is
  present, the service must prove its identity by sending its
  [identity token][4] in the `x-onedata-service-token` header.
  The services  must be encoded using the proper [service format][13].
  If no such caveat is included in a token, it can be used in any service.
  ```json
  {
      "type": "service",
      "whitelist": [
          "ozw-onezone",
          "ozp-onezone",
          "opw-*",
          "opp-01c4455bef059353c9dfb35ba93a24f3"
      ]
  }
  ```
  > NOTE: when adding `service` caveats, keep in mind that if your requests
  > need to be proxied to another Oneprovider, it must also be whitelisted.
  > Proxying happens when the Oneprovider that received your request does not
  > support the concerned space.

* `consumer` - limits the [consumers][10] that can utilize the token. If
  the caveat is present, the consumer must prove their identity by sending their
  [identity token][4] in the `x-onedata-consumer-token` header.
  The consumers must be encoded using the proper [consumer format][14].
  If no such caveat is included in a token, it can be used by any bearer.
  ```json
  {
      "type": "consumer",
      "whitelist": [
          "usr-d4f5876dbe7f1e7e8a511de6dd31144c",
          "grp-0921135ee61fe53a3df449365228e9b4",
          "prv-*"
      ]
  }
  ```

* `interface` - limits the available interfaces on which the token can be used
  to a certain one — `rest`, `oneclient` or `graphsync`. If the `oneclient`
  interface is specified, this caveat is treated as a
  [*data access caveat*][15]. The `graphsync` interface is
  used internally for communication between services and does not make sense
  in tokens created by users. If no such caveat is included in a token, it can
  be used on all interfaces.
  ```json
  {
      "type": "interface",
      "interface": "rest"
  }
  ```

* `api` - limits the API operations that can be performed with the token. The
  operations are whitelisted using the Onedata API matchspec format, which
  however is currently used only internally. Adding information how to build
  matchspecs is on the roadmap for official API documentation. If no such
  caveat is included in a token, it can be used for all API calls.
  ```json
  {
      "type": "api",
      "whitelist": [
          "ozw/all/user.*.*:*",
          "all/get/space.*.*:*"
      ]
  }
  ```

* `data.readonly` - allows only read access to user files. This is a
  [*data access caveat*][15]. If no such caveat is included in
  a token, it can be used for both reading and writing data.
  ```json
  {
    "type": "data.readonly"
  }
  ```

* `data.path` - limits the paths in which data can be accessed with the token.
  The paths must be canonical - starting with a slash + space ID, and without
  a trailing slash - and must be base64 encoded. If a directory path is given,
  the token allows to access all nested files and directories starting from
  the specified directory. This is a [*data access caveat*][15].
  If no such caveat is included in a token, it can be used for accessing all
  user files.
  ```json
  {
      "type": "data.path",
      "whitelist": [
          "L2QxYjM4OGY3Yzc=",
          "LzhkZjFlYjkwYTcvZGlyL2ZpbGUudHh0Cg=="
      ]
  }
  ```
  ```
  "L2QxYjM4OGY3Yzc="                      ==  base64("/d1b388f7c7")
  "LzhkZjFlYjkwYTcvZGlyL2ZpbGUudHh0Cg=="  ==  base64("/8df1eb90a7/dir/file.txt")
  ```

* `data.objectid` - limits the object IDs in which data can be accessed with the
  token. The object IDs comply with the CDMI format and can be used in the
  Oneprovider's REST and CDMI APIs. If a directory object ID is given, the
  token allows to access all nested files and directories starting from the
  specified directory. This is a [*data access caveat*][15].
  If no such caveat is included in a token, it can be used for accessing all
  user files.
  ```json
  {
      "type": "data.objectid",
      "whitelist": [
          "000000000055D4E4836803640004677569646D000000167",
          "39592D594E736C676D0000002B43592D347247454C535F6"
      ]
  }
  ```
  > NOTE: `data.objectid` caveats are computationally heavier than `data.path`
  > caveats - you should use the latter whenever possible for performance
  > reasons. Nevertheless, `data.objectid` have the advantage that they remain
  > valid even if the target file is moved / renamed (given that the File ID
  > does not change in the process) - contrary to `data.path` caveats.

### Caveats compatibility

Below table shows compatibility of caveats with access, identity and invite
tokens. Note that adding an unrecognized or incompatible caveat causes the token
to always fail verification (renders it unusable in practice).

* <span style="color:#480"> allowed </span> - the caveat is recognized and will
  be checked against the request context
* <span style="color:red"> rejected </span> - presence of this caveat will cause
  immediate token verification failure

| Caveat        |               Access tokens               |              Identity tokens              |               Invite tokens               |
| ------------- | :---------------------------------------: | :---------------------------------------: | :---------------------------------------: |
| time          | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| ip            | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| asn           | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| geo.country   | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| geo.region    | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| service       | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> | <span style="color:red"> rejected </span> |
| consumer      | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| interface     | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> |
| api           | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> | <span style="color:red"> rejected </span> |
| data.readonly | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> | <span style="color:red"> rejected </span> |
| data.path     | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> | <span style="color:red"> rejected </span> |
| data.objectid | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> | <span style="color:red"> rejected </span> |

> Identity tokens do not allow `service`, `api` or *data access caveats* as these
> caveats are only relevant when requesting data access or an API operation.

> Invite tokens are specialized for one operation and always used in the Onezone
> service, hence they allow only suitable caveats.

### Data access caveats

*Data access caveats* are a special kind of caveat that carry additional, implicit
restrictions. Existence of **any data access caveat** in a token determines that
the token is intended exclusively for accessing user files and causes all other
APIs to be disallowed or limited to the minimum required to handle data access
requests. Such tokens can only be used in the Oneprovider service for REST/CDMI
operations on files or mounting Oneclient.

The list of *data access caveats*:

* `interface`, but only if equal to `oneclient`
* `data.readonly`
* `data.path`
* `data.objectid`

The idea behind *data access caveats* is to impose high level of security when
token intended for data access is delegated. For example, it is possible to
create a token with `data.path` and `data.readonly` caveats, limiting the rights
to readonly access in a single directory. Such token can be published online
without the risk of malicious utilization
(see [safely publishing tokens][9]) - the token forbids
any API operations and can be used solely to read the specified directory.

> These restrictions improve security, but the downside is that it is not
> possible to grant somebody restricted access to files and the system API at the
> same time with one token - two different tokens must be created. The alternative
> would be to make no implicit restrictions and expect users to consciously limit
> the token with `api` caveats whenever they wish to safely publish it. That,
> however, was deemed too obscure, unintuitive and risky, as it would require a
> deep knowledge of the underlying mechanisms.

### Caveats impact on services

Each caveat can have a big impact on the token usability in the system,
depending on the type. Above-mentioned *data access caveats* are a good
example - their presence in the token greatly restricts the available services.
Beside that, there are some other considerations of token caveat usage,
summarized in the below tables.

* <span style="color:#480"> allowed </span> - the caveat is recognized and will
  be checked against the request context
* <span style="color:red"> rejected </span> - presence of this caveat will cause
  immediate token verification failure
* <span style="color:#aa0"> restricted </span> - the caveat is allowed only in
  certain circumstances - see footnotes for details

#### Onezone

| Interface             |                    REST                    |           GraphSync<sup>1</sup> (GUI)           |           GraphSync<sup>1</sup> (Oneprovider)           |
| --------------------- | :----------------------------------------: | :---------------------------------------------: | :-----------------------------------------------------: |
| time                  | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> |     <span style="color:#480"> allowed        </span>    |
| ip                    | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> |     <span style="color:#480"> allowed        </span>    |
| asn                   | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> |     <span style="color:#480"> allowed        </span>    |
| geo.country           | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> |     <span style="color:#480"> allowed        </span>    |
| geo.region            | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> |     <span style="color:#480"> allowed        </span>    |
| service               | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> |     <span style="color:#480"> allowed        </span>    |
| consumer              | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> |     <span style="color:#480"> allowed        </span>    |
| interface<sup>2</sup> | <span style="color:#aa0"> `"rest"` </span> | <span style="color:#aa0"> `"graphsync"` </span> | <span style="color:#aa0"> restricted<sup>3</sup></span> |
| api                   | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> |     <span style="color:#480"> allowed        </span>    |
| data.readonly         | <span style="color:red">  rejected </span> | <span style="color:red">  rejected      </span> | <span style="color:#aa0"> restricted<sup>3</sup></span> |
| data.path             | <span style="color:red">  rejected </span> | <span style="color:red">  rejected      </span> | <span style="color:#aa0"> restricted<sup>3</sup></span> |
| data.objectid         | <span style="color:red">  rejected </span> | <span style="color:red">  rejected      </span> | <span style="color:#aa0"> restricted<sup>3</sup></span> |

<sup>1</sup>
The GraphSync interface is used internally for communication between services
and is not used directly by users, but is included in the table for reference.
The information in the table is the same for the GraphSync interfaces of
Oneprovider and Onepanel and omitted in tables that follow.

<sup>2</sup>
The interface caveat must match the interface on which the request has been
made, as shown in the table. There is one exception - the Oneprovider GraphSync
channel, where Onezone accepts all types of tokens that were delegated by users
to Oneproviders, but the included caveats can impose further restrictions
(e.g. when interface is equal to `"oneclient"`).

<sup>3</sup>
Oneprovider service uses the GraphSync channel to fetch user data from Onezone.
It uses the token that was passed to it by the user, either when they made a call
to the REST/CDMI API, mounted a Oneclient, or visited the Oneprovider GUI (which
utilizes a gui access token in the background). If the token contains any of the
*data access caveats*, Onezone will allow to fetch only the basic user info,
necessary to handle the request, and block all other API operations. Even if the
Oneprovider is malicious and somehow managed to trick the user into trusting it,
it will not be able to cause any damage with such token.

#### Oneprovider

| Interface             |                       Oneclient                       | CDMI & REST<sup>1</sup><br/>(data access operations) |   REST<sup>2</sup><br/>(other operations)  |
| --------------------- | :---------------------------------------------------: | :--------------------------------------------------: | :----------------------------------------: |
| time                  |    <span style="color:#480"> allowed       </span>    |      <span style="color:#480"> allowed  </span>      | <span style="color:#480"> allowed  </span> |
| ip                    |    <span style="color:#480"> allowed       </span>    |      <span style="color:#480"> allowed  </span>      | <span style="color:#480"> allowed  </span> |
| asn                   |    <span style="color:#480"> allowed       </span>    |      <span style="color:#480"> allowed  </span>      | <span style="color:#480"> allowed  </span> |
| geo.country           |    <span style="color:#480"> allowed       </span>    |      <span style="color:#480"> allowed  </span>      | <span style="color:#480"> allowed  </span> |
| geo.region            |    <span style="color:#480"> allowed       </span>    |      <span style="color:#480"> allowed  </span>      | <span style="color:#480"> allowed  </span> |
| service               |    <span style="color:#480"> allowed       </span>    |      <span style="color:#480"> allowed  </span>      | <span style="color:#480"> allowed  </span> |
| consumer              | <span style="color:red">  rejected<sup>3</sup></span> |      <span style="color:#480"> allowed  </span>      | <span style="color:#480"> allowed  </span> |
| interface<sup>4</sup> |    <span style="color:#aa0"> `"oneclient"` </span>    |      <span style="color:#aa0"> `"rest"` </span>      | <span style="color:#aa0"> `"rest"` </span> |
| api                   |    <span style="color:#480"> allowed       </span>    |      <span style="color:#480"> allowed  </span>      | <span style="color:#480"> allowed  </span> |
| data.readonly         |    <span style="color:#480"> allowed       </span>    |      <span style="color:#480"> allowed  </span>      | <span style="color:red">  rejected </span> |
| data.path             |    <span style="color:#480"> allowed       </span>    |      <span style="color:#480"> allowed  </span>      | <span style="color:red">  rejected </span> |
| data.objectid         |    <span style="color:#480"> allowed       </span>    |      <span style="color:#480"> allowed  </span>      | <span style="color:red">  rejected </span> |

<sup>1</sup>
Data access operations include the whole CDMI API and REST endpoints to manage
file and directory contents, metadata, permissions and ACLs. These endpoints
can be accessed with tokens that include a *data access caveat*.

<sup>2</sup>
Other REST operations include the API for: shares, spaces, views,
replicas & transfers, QoS, monitoring and datastore changes stream.
These endpoints are forbidden when the token includes a *data access caveat*.

<sup>3</sup>
Currently it is not possible to provide a consumer token when mounting Oneclient,
which makes it impossible to verify consumer caveats on this interface.

<sup>4</sup>
The interface caveat must match the interface on which the request has been
made, as shown in the table.

#### Onepanel

| Interface     |                 REST (Onezone panel)                 |               REST (Oneprovider panel)               |
| ------------- | :--------------------------------------------------: | :--------------------------------------------------: |
| time          |     <span style="color:#480"> allowed     </span>    |     <span style="color:#480"> allowed     </span>    |
| ip            |     <span style="color:#480"> allowed     </span>    | <span style="color:red"> rejected<sup>1</sup></span> |
| asn           |     <span style="color:#480"> allowed     </span>    | <span style="color:red"> rejected<sup>1</sup></span> |
| geo.country   |     <span style="color:#480"> allowed     </span>    | <span style="color:red"> rejected<sup>1</sup></span> |
| geo.region    |     <span style="color:#480"> allowed     </span>    | <span style="color:red"> rejected<sup>1</sup></span> |
| service       |     <span style="color:#480"> allowed     </span>    |     <span style="color:#480"> allowed     </span>    |
| consumer      |     <span style="color:#480"> allowed     </span>    |     <span style="color:#480"> allowed     </span>    |
| interface     | <span style="color:red"> rejected<sup>2</sup></span> | <span style="color:red"> rejected<sup>2</sup></span> |
| api           |     <span style="color:#480"> allowed     </span>    |     <span style="color:#480"> allowed     </span>    |
| data.readonly |     <span style="color:red"> rejected     </span>    |     <span style="color:red"> rejected     </span>    |
| data.path     |     <span style="color:red"> rejected     </span>    |     <span style="color:red"> rejected     </span>    |
| data.objectid |     <span style="color:red"> rejected     </span>    |     <span style="color:red"> rejected     </span>    |

<sup>1</sup>
Currently, only Onezone panel supports the IP related caveats (including
ASN, country and region, which are checked using a GEO IP database). The
support in Oneprovider panel is under implementation. For that time, tokens
with such caveats are immediately rejected.

<sup>2</sup>
Currently, the support for `interface` caveat in both Onepanels is under
implementation. For that time, tokens with such caveats are immediately rejected.

## Service

Service is the Onedata service that received the client's request and is
handling their access token. For example, the Oneprovider service chosen by a
user to mount a Oneclient or make a CDMI request.

It is possible to limit the allowed services using the `service` caveat. In such
case, the service that received the request must be whitelisted, otherwise the
operation will not be authorized. Behind the scenes, the service must prove its
identity by sending its identity token to Onezone.

### Service types

There are 4 service types in Onedata. Note the serialized format in the table
below if you wish to use the [REST API][8] for creating tokens
with `service` caveats - the first three letters denote the type, and the rest
after the hyphen is the ID of the corresponding Oneprovider or special
`onezone` keyword for the Onezone service.

| Service                        |             Examples (serialized format)             |
| ------------------------------ | :--------------------------------------------------: |
| Onezone                        |                     `ozw-onezone`                    |
| Onezone panel (for admins)     |                     `ozp-onezone`                    |
| Oneprovider                    | `opw-01c4455bef059353c9dfb35ba93a24f3` <br/> `opw-*` |
| Oneprovider panel (for admins) | `opp-01c4455bef059353c9dfb35ba93a24f3` <br/> `opp-*` |

> Note: the special `*` service ID can be used to allow any service of given
> type (e.g. any Oneprovider service).

### Service caveat considerations

Service caveats impose implicit API limitations depending on the whitelisted
services. It is **strongly recommended** to include a service caveat in all tokens
that are used to access services other than Onezone - this way, the service
is given limited power to perform operations on behalf of the user, restricted
to the necessary minimum. For example, a token used to mount a Oneclient should
be confined with a service caveat that whitelists just the Oneprovider service.
Such token cannot be used in Onezone API for any (possibly malicious) operations,
which ensures security even if the Oneprovider service is not fully trusted.

## Consumer

Consumer is the token bearer that utilizes the token - performs a request with
an access token or attempts to consume an invite token. It is possible to create
a token that will only be consumable by whitelisted subjects. Consider Bob, who
creates an access token allowing to access his space and adds a `consumer`
caveat that limits the allowed consumers to Alice:

```json
{
    "type": "consumer",
    "whitelist": [
        "usr-5c9dfb35db55bef7e8a51dfb35ba93a2"
    ]
}
```

* `5c9dfb35db55bef7e8a51dfb35ba93a2` - Alice's user ID

Then, Bob passes the confined token to Alice. In such case, Alice has to prove
her identity by adding her [identity token][4] to the request:

```bash
~$ curl -H "x-auth-token: ${BOBS_ACCESS_TOKEN}" \
        -H "x-onedata-consumer-token: ${ALICES_IDENTITY_TOKEN}" \
        -X GET ...
```

Without a valid `x-onedata-consumer-token` belonging specifically to Alice, the
request will fail with unverified caveat error.

### Consumer types

There are 3 consumer types in Onedata. Note the serialized format in the table
below if you wish to use the [REST API][8] for creating tokens
with `consumer` caveats - the first three letters denote the type, and the rest
after the hyphen is the ID of the corresponding user / group / Oneprovider.

| Consumer    |             Examples (serialized format)             |
| ----------- | :--------------------------------------------------: |
| user        | `usr-d4f5876dbe7f1e7e8a511de6dd31144c` <br/> `usr-*` |
| group       | `grp-0921135ee61fe53a3df449365228e9b4` <br/> `grp-*` |
| Oneprovider | `prv-01c4455bef059353c9dfb35ba93a24f3` <br/> `prv-*` |

> Note: group is a special consumer that can be put into the `consumer` caveat's
> whitelist. It will be successfully verified if the request's consumer is a user
> that belongs to the specified group.

> Note: the special `*` consumer ID can be used to allow any consumer of given
> type (e.g. any user or any Oneprovider).

## Safely publishing tokens

It is possible to create a token with very limited rights and safely publish it
online so anyone can use it to access user's resources. Nevertheless, it must
always be done with great care, as the bearer of the token can perform
operations on behalf of the issuing subject. If the published token is too open,
anyone might be able to tinker with user's account and data.

When creating a token for public use, consider the following:

* Make sure to include carefully chosen [*data access caveats*][15]
  in the token (`data_readonly`, `data_path`, `data_objectid`). In a typical scenario,
  you may want to allow readonly access to a certain subset of your data.

* In rare cases, you can use an `api` caveat to enable a very specific API
  operation that you want to be publicly available in your name. Remember that
  `api` and *data access caveats* [do not go together][15].

* It may be reasonable to use an `interface` caveat and specify the interface
  on which the token will be exclusively accepted. For example, if `oneclient`
  interface is specified, the token bearer will not be able to perform any API
  operations via REST, which increases security.

* Consider using `consumer` caveats to limit the available consumers of the
  token and `service` caveats to make the token usable only in chosen services.

* Make sure to create a `named` token to be able to revoke or delete it at any
  time.

## Security and privacy considerations

Here are some technical details concerning the security and privacy when using
or delegating access tokens:

* You should always keep your tokens safe, just like you would do with your
  passwords, certificates or private keys. The exceptions are when passing an
  invite token to somebody you wish to invite or when delegating an access
  token that has been properly limited by caveats.

* It is strongly recommended to include a
  [service caveat][12] in all tokens that are used
  outside of Onezone service.

* When a Oneprovider or Oneprovider panel service receives a request along with
  an access token, it is required that the token's subject user trusts the service
  and is entitled to use it. In case of Oneprovider, the user must be supported
  by the Oneprovider - must have access to at least one space that is supported by
  the Oneprovider, which implies bidirectional trust between the user and the
  Oneprovider. To use a Oneprovider panel service, the user must be a member of
  the cluster corresponding to the Oneprovider. If above conditions are not met,
  authorization is declined. This is checked by Onezone when releasing user data.
  It is not possible to utilize the token in an untrusted Oneprovider, which
  protects from data exfiltration.

* Tokens with [*data access caveats*][15] can be used only on
  Oneprovider interfaces (Oneclient / REST / CDMI). When using such token, the
  bearer is not able to learn token subject's account information or private data.
  The information is processed by the Oneprovider to handle the request, but never
  disclosed to the client. As stated in previous point, the Oneprovider must be
  supporting the subject user, which implies that it is trusted.

* *Data access caveats* [implicitly limit the available APIs][16]
  to a minimum so that the token bearer cannot perform any modifications to
  subject's account or read private information.

* `data_path` and `data_objectid` caveats imply in which spaces the token can be
  used - other spaces are completely invisible and inaccessible to the token bearer.

## Using REST API

Below are some examples how the REST API can be used to manage user tokens. For
detailed documentation of all endpoints, refer to the
[API documentation][17].

Below examples assume that the following envs are exported:

```bash
REST_API="https://<onezone-domain>/api/v3/onezone"
AUTH_HEADER="x-auth-token: <your-access-token>"
CT="content-type: application/json"
```

#### Create a temporary access token valid for 1 hour

Find out current time in Onezone:

```bash
curl ${REST_API}/provider/public/get_current_time
```

```json
{"timeMillis": 1582046102940}
```

Divide by 1000 to get time in seconds, add 3600 (1 hour validity) and use in
a `time` caveat:

```bash
curl -H "${AUTH_HEADER}" -H "${CT}" -X POST ${REST_API}/user/tokens/temporary -d '{
  "type": {
    "accessToken": {}
  },
  "caveats": [
    {
      "type": "time",
      "validUntil": 1582049702
    }
  ]
}'
```

```json
{"token": "MDAyMGxvY2F00aW9uIG96LjE1ODIwNDY1MzcudGVzdAowMDRjciAyL3Rt..."}
```

#### Create a named access token for mounting Oneclient in specific Oneprovider

Identify the ID of the desired Oneprovider - you can visit the web GUI and go to
the Overview tab in the Oneprovider. Assume the ID is `3fe8f8eafb53c7205eeffde461a50348chfaf0`.

```bash
curl -H "${AUTH_HEADER}" -H "${CT}" -X POST ${REST_API}/user/tokens/named -d '{
  "name": "Oneclient access token",
  "type": {
    "accessToken": {}
  },
  "caveats": [
    {
      "type": "interface",
      "interface": "oneclient"
    },
    {
      "type": "service",
      "whitelist": ["opw-3fe8f8eafb53c7205eeffde461a50348chfaf0"]
    }
  ]
}'
```

```json
{
  "tokenId": "4c71496ba3dff0052c04c697b12fe157ch9a1f",
  "token": "MDAyMGxvY2F00aW91MzcudGVzdAowMuIGF00aW9uIG9696LjEA1OIwND..."
}
```

This token can be used only in the Oneprovider with specified ID and only for
mounting Oneclient.

#### Create a named token for readonly access in a specific directory

Assume that `39592D594E736C676D0000002B43592D347247454C535F6` is the
[File ID][18] of the directory that is to be available with the token.

```bash
curl -H "${AUTH_HEADER}" -H "${CT}" -X POST ${REST_API}/user/tokens/named -d '{
  "name": "Readonly access to experiment data",
  "type": {
    "accessToken": {}
  },
  "caveats": [
    {
      "type": "data.readonly"
    },
    {
      "type": "data.objectid",
      "whitelist": [
        "39592D594E736C676D0000002B43592D347247454C535F6"
      ]
    }
  ]
}'
```

```json
{
  "tokenId": "0052c06ba3d7ch9a1ff2fe154c697b14c7149f",
  "token": "MDAyMGxvY2F00aW91MzcudGVzdAowMuIGF00aW9uIG9696LjEA1OIwND..."
}
```

Such token can be used only for readonly access to files in the specified
directory (and its subdirectories).

#### Create a named token valid only for a colleague

Refer to the scenario [described before][10]. Assume that Bob
wishes to create a token for Alice (user ID `461698917aa4c176fd86a111b6e7231ca998f1`)
that would allow data access in whole space `e8df04bb7a8f9a644a773daf24fe631bchd5c2`.
Note:

```bash
echo "/e8df04bb7a8f9a644a773daf24fe631bchd5c2" | base64
```

```bash
L2U4ZGYwNGJiN2E4ZjlhNjQ0YTc3M2RhZjI0ZmU2MzFiY2hkNWMyCg==
```

Bob's token (note `${BOBS_AUTH_HDR}`):

```bash
curl -H "${BOBS_AUTH_HDR}" -H "${CT}" -X POST ${REST_API}/user/tokens/named -d '{
  "name": "Access token for Alice",
  "type": {
    "accessToken": {}
  },
  "caveats": [
    {
      "type": "consumer",
      "whitelist": ["usr-461698917aa4c176fd86a111b6e7231ca998f1"]
    },
    {
      "type": "data.path",
      "whitelist": [
        "L2U4ZGYwNGJiN2E4ZjlhNjQ0YTc3M2RhZjI0ZmU2MzFiY2hkNWMyCg=="
      ]
    }
  ]
}'
```

```json
{
  "tokenId": "61ff25052c04c7ba3d7ch94c697b10afe1149f",
  "token": "MDAyMGxvY2F00aW91MzcudGVzdAowMuIGF00aW9uIG9696LjEA1OIwND..."
}
# BOBS_ACCESS_TOKEN
```

Alice needs to create an identity token to be able to use Bob's token (note `${ALICES_AUTH_HDR}`):

```bash
curl -H "${ALICES_AUTH_HDR}" -H "${CT}" -X POST ${REST_API}/user/tokens/temporary -d '{
  "type": {
    "identityToken": {}
  },
  "caveats": [
    {
      "type": "time",
      "validUntil": 1582049702
    }
  ]
}'
```

```json
{"token": "MDAyMGxvY2F00aW9uIG96LjE1ODIwNDY1MzcudGVzdAowMDRjciAyL3Rt..."}
# ALICES_IDENTITY_TOKEN
```

Now, Alice can use the tokens like below for accessing the data in the space:

```bash
~$ curl -H "x-auth-token: ${BOBS_ACCESS_TOKEN}" \
        -H "x-onedata-consumer-token: ${ALICES_IDENTITY_TOKEN}" \
        -X GET ...
```

#### Create a named invite token for requesting space support with 4 uses

Identify the ID of the desired space - you can visit the web GUI and go to
the Overview tab in the space. Assume the ID is `e8df04bb7a8f9a644a773daf24fe631bchd5c2`.

```bash
curl -H "${AUTH_HEADER}" -H "${CT}" -X POST ${REST_API}/user/tokens/named -d '{
  "name": "Support token for My Experiment",
  "type": {
    "inviteToken": {
      "inviteType": "supportSpace",
      "spaceId": "e8df04bb7a8f9a644a773daf24fe631bchd5c2"
    }
  },
  "usageLimit": 4
}'
```

```json
{
  "tokenId": "28a45b0ce12fefe8e098e9d8c238d74fch4f69",
  "token": "MDAyMGxvY2F00aW91MzcudGVzdAowMuIGF00aW9uIG9696LjEA1OIwND..."
}
```

The token can be used 4 times (only successful attempts count). You can pass the
token to four different Oneproviders and ask for support.

#### Create a named invite token for inviting space members with certain privileges

Identify the ID of the desired space - you can visit the web GUI and go to
the Overview tab in the space. Assume the ID is `e8df04bb7a8f9a644a773daf24fe631bchd5c2`.

```bash
curl -H "${AUTH_HEADER}" -H "${CT}" -X POST ${REST_API}/user/tokens/named -d '{
  "name": "User invite for My Experiment",
  "type": {
    "inviteToken": {
      "inviteType": "userJoinSpace",
      "spaceId": "e8df04bb7a8f9a644a773daf24fe631bchd5c2"
    }
  },
  "privileges": ["space_view", "space_read_data", "space_write_data"]
}'
```

```json
{
  "tokenId": "ce3cec620a003576b279ddd533777ec1ch34dd",
  "token": "MDAyMGxvY2F00aW9uIG96LjE1ODIwNDY..."
}
```

Whoever consumes the token will join the space with privileges:
`["space_view", "space_read_data", "space_write_data"]`. The token has no usage
limit.

#### Revoke the previously created invite token for inviting space members

Named token create operation returns the `tokenId`, which can be used to refer
to the named token. Note the ID returned in the previous example. The token can
be revoked like this:

```bash
curl -H "${AUTH_HEADER}" -H "${CT}" -X PATCH \
${REST_API}/tokens/named/ce3cec620a003576b279ddd533777ec1ch34dd -d '{
  "revoked": true
}'
```

From now on, the invite token will not work. Revocation can be toggled at will:

```bash
curl -H "${AUTH_HEADER}" -H "${CT}" -X PATCH \
${REST_API}/tokens/named/ce3cec620a003576b279ddd533777ec1ch34dd -d '{
  "revoked": false
}'
```

The token can be used again.

## GUI guide

### Access token quickstart

The easiest way to obtain an access token is to navigate to the **TOKENS** tab,
click on the **(+)** button and choose the template the best suits your needs.
You can use the default settings or tailor the token to a specific use-case,
possibly limiting it with caveats. In such case, see the detailed guide [below][19].
![image][20]

### Consuming invite tokens

Invite tokens are used to create relations in the system, e.g. add
new members to a group or space. In case you receive any invite token, simply
navigate to the **TOKENS** tab and use the **Consume** action. Paste the token
into the visible text field. Shortly afterwards you should see the details of
the invitation carried by the token. Confirm to accept the invitation.
![image][21]

### Detailed guide

Recommended for users that want to familiarize with the advanced features
offered by Onedata tokens and the token creation GUI wizard.

1. Navigate to the **TOKENS** tab. Click on **(+)** or **Get started** to create a new token.
   Click on **Consume** if you received an invite token in order to utilize the invitation.
   ![image][22]

2. When you choose the action to create a new token, you will be presented with
   a wizard with quick templates. Choose the one most appropriate for your use case.
   Familiarize yourself with the hints displayed on the page. Go through different
   templates and examine the suggested caveats.
   ![image][23]

3. Use the **Create custom token** action to create your own access token.
   Give it a meaningful name and restrict it with some [caveats][7].
   Below example would create a token with a limited lifespan that can be used only
   for accessing Oneprovider services (note the service caveat). Effectively, this
   limits the available interfaces to those offered by Oneprovider: Oneclient and
   REST/CDMI API. They can be further limited using the interface caveat (the first below).
   ![image][24]

4. Consider adding other caveats to increase your security in case the token
   is to be delegated or passed to another user. Below
   [*data access caveats*][15] would restrict the token's power
   to just reading the contents of specified directory and file. Any other
   operation will be denied by all system components.
   ![image][25]

5. You may want to create an [identity token][4] for more
   advanced scenarios that entail [consumer][10] caveats:
   ![image][26]

6. Invite tokens can be created easily in the members submenu of a group / space etc.
   ![image][27]
   though you may want to create a custom token using the wizard:
   ![image][28]

7. Created token will be listed on the left - you can view the details of a
   token and copy it in serialized form that can be used in CLI, e.g. to mount
   Oneclient or perform a request to REST/CDMI, or passed to some
   scripts / middleware.
   ![image][29]

8. Tokens can be modified to some extent - renamed or revoked. Other details,
   such as caveats, are not modifiable as they are inscribed in the token.
   ![image][30]

[Google's macaroons]: https://ai.google/research/pubs/pub41892

[1]: <>

[2]: #gui-guide

[3]: #access-tokens

[4]: #identity-tokens

[5]: #invite-tokens

[6]: #named-and-temporary-tokens

[7]: #token-caveats

[8]: #using-rest-api

[9]: #safely-publishing-tokens

[10]: #consumer

[11]: #service

[12]: #service-caveat-considerations

[13]: #service-types

[14]: #consumer-types

[15]: #data-access-caveats

[16]: #caveats-impact-on-services

[17]: https://onedata.org/#/home/api/latest/onezone?anchor=tag/Token

[18]: data.md#file-path-and-id

[19]: #detailed-guide

[20]: ../../images/user-guide/tokens/0-access-token-templates.png#screenshot

[21]: ../../images/user-guide/tokens/0-consume-token.png#screenshot

[22]: ../../images/user-guide/tokens/1-no-tokens.png#screenshot

[23]: ../../images/user-guide/tokens/2-token-wizard.png#screenshot

[24]: ../../images/user-guide/tokens/3-access-token.png#screenshot

[25]: ../../images/user-guide/tokens/4-data-access-caveats.png#screenshot

[26]: ../../images/user-guide/tokens/5-identity-token.png#screenshot

[27]: ../../images/user-guide/tokens/6-invite-token-a.png#screenshot

[28]: ../../images/user-guide/tokens/6-invite-token-b.png#screenshot

[29]: ../../images/user-guide/tokens/7-browse-tokens.png#screenshot

[30]: ../../images/user-guide/tokens/8-modify-token.png#screenshot
