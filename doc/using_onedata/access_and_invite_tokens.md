# Access & Invite Tokens

This documentation is valid for system versions `20.02.*` or newer. Basic 
information about legacy tokens for versions up to `19.02.*` can be found 
[here](./using_onedata_from_cli.md).

<!-- toc -->

## Basics

There are three types of tokens in Onedata: access tokens, invite tokens and 
GUI access tokens. The latter are reserved for internal use in the web 
applications and are invalid when used outside of this scope. Access and invite
tokens are available for the end user to create, manage and utilize.

Regardless of the above-mentioned type, each token can be 
[named or temporary](#named-and-temporary-tokens).

Tokens are passed around the system in a serialized form - an alphanumeric 
string that can look like the following:
`MDAxNWxvY2F00aW9uIG9uZXpvbmUKMDAzYmlkZW500aWZpZXIgRHR00WTg5dH...`

Onedata uses [Google's macaroons] for underlying implementation of tokens, with
support for [caveats](#token-caveats) - contextual confinements.

All tokens are created in Onezone and can only be verified by Onezone.

Tokens can be created using the wizard in Onezone web GUI or the [REST API].


## Access tokens

Access tokens are the basic way to authorize operations in Onedata - either in 
REST/CDMI API or when mounting Oneclient. Access tokens are a type of bearer 
authentication, which means that the party in possession of a token can use it 
to perform operations on behalf of the token subject (creator). The subject can 
be either a user or a Oneprovider service. For clarity, this documentation talks 
about user tokens, but all the aspects are symmetrical for Oneproviders.

Access tokens carry the identity of the subject that created the token. From the
system's point of view, the token bearer is indistinguishable from the subject. 
Consider this example:

1. Bob creates a token and gives it to Alice

2. Alice uses the token to authorize a request

3. The system identifies the requesting subject as Bob, authorizes and handles 
   the request in this context, operating on Bob's data. It does not matter if
   the requesting client (token bearer) was Alice or Bob.

Access tokens are a powerful tool for authority delegation, but at the same time
require caution - they must be kept secret, similarly to user passwords. However,
thanks to support for [caveats](#token-caveats) (contextual confinements), 
tokens can be limited with fine granularity, making it safer to delegate them to 
other users or services. Nevertheless, you should never disclose your tokens to 
a party that is not trusted.
   
Authorization in Onedata depends on the identity of the requesting party 
(token's subject), subject's relations and privileges (e.g. space membership and
the privileges in the space), as well as token's caveats. For example, for Bob
to be able to create a file in space `My experiment`, all below requirements 
need to be satisfied:

1. Requesting party must present a valid token with `subject = Bob`

2. Bob must be a member of the space `My experiment`

3. Bob must have `space_write_data` privilege in space `My experiment`

4. The access token must allow writing in space `My experiment` 
   (or to be accurate, token caveats must not forbid writing in the space)


## Invite tokens

Invite tokens in Onedata are used to create relations in the system. They can be 
consumed by anyone who possesses the token. Typical scenario is that the 
inviting user generates a token and passes it to somebody that he wishes to 
invite, and the other user consumes the token and is added to the target 
entity (e.g. group or space).

The Onezone Web GUI provides a comprehensive wizard for creating invite tokens
with different parameters. Below is some technical information about the invite
tokens which might be useful for [REST API] users.

Invite tokens can have one of the following types:

* `userJoinGroup` - can be consumed to join the target group of the 
    invitation as a user
    
* `groupJoinGroup` - can be consumed to join the target group (parent) of 
    the invitation as a group (child)
    
* `userJoinSpace` - can be consumed to join the target space of the 
    invitation as a user
    
* `groupJoinSpace` - can be consumed to join the target space of the 
    invitation as a group   
                    
* `supportSpace` - can be consumed by a Oneprovider to grant support 
    (storage space) to the target space of the invitation
    
* `registerOneprovider` - can be consumed to register a new Oneprovider and link
    it to the target user (who becomes an admin of the 
    Oneprovider service)
* `userJoinCluster` - can be consumed to join the target cluster of the 
    invitation as a user
    
* `groupJoinCluster` - can be consumed to join the target cluster of the 
    invitation as a group 
    
* `userJoinHarvester` - can be consumed to join the target harvester of the 
    invitation as a user
    
* `groupJoinHarvester` - can be consumed to join the target harvester of the 
    invitation as a group   
                           
* `spaceJoinHarvester` - can be consumed to join the target harvester of the 
    invitation as a space, so that the space becomes a
    metadata source for the harvester.                            

The invite token type must be coupled with the target entity id of the 
invitation (e.g. the space Id for which the token was created).

Invite tokens can be created by authorized users, for example a `userJoinSpace` 
token can be created by a member of the target space that has the 
`space_add_user` privilege. 

[Named](#named-and-temporary-tokens) invite tokens can have additional parameters, 
which are optional:

1. Carried privileges (if applicable) - defines what privileges will be granted
   for the joining member upon token consumption. If not specified, default 
   member privileges will be granted.
   
2. Usage limit - defines how many times the token can be used. If not specified,
   there is no limit.


## Named and temporary tokens

Tokens in Onedata can be temporary or named, regardless of the type (access 
or invite). Temporary tokens are short lived and not persisted, while named 
tokens are linked to user's account and retrievable. All differences are shown 
in below table.


| Temporary tokens                                                 | Named tokens                                                     |
|------------------------------------------------------------------|------------------------------------------------------------------|
| no identification in the system                                  | must have a unique name                                          |
| not persisted                                                    | persisted                                                        |
| cannot be retrieved <br/> _you must store the token right when you create it_ | linked to subject's account                         |
| shared secret <br/> _the secret can be regenerated, in this case all subject's temporary tokens become invalid_ | individual secret |
| cannot be deleted individually <br/> _see shared secret above_   | can be deleted <br/> _(the token immediately becomes invalid_    |
| non-revocable individually <br/> _see shared secret above_       | revocable <br/> _revocation can be undone at will_               |
| must have limited lifespan <br/> _max permitted lifespan is configurable by Onezone admin_ | can have infinite lifespan             |
| no accounting, cannot be listed                                  | can be listed in [REST API] or viewed in web GUI                 |
| useful for automated software / middleware / scripting           | require more management but ensure full control                  |
  
  
## Token caveats

Each token can have any number of caveats (including 0). Caveats are a 
fundamental concept of [Google's macaroons] (which are used for token 
implementation in Onedata). Caveats are contextual confinements - they limit the
context in which a token is valid. They are inscribed in the token itself,
which enables powerful delegation features. Thanks to cryptographic signatures,
caveats cannot be removed from a token. However, they can be added to any token
by any party that possesses the token. Such operation further limits the token,
making it carry less power that the original one. Such limited token can be
safely passed to another party, which won't be able to overcome the limitations
without knowing the original token. Consider this example:

1. Bob creates a named token `Alpha` for accessing his data, but only in the 
    space `My experiment` - using the `data.path` caveat.

2. Bob confines the token `Alpha` - adds the `data.readonly` caveat - and 
    obtains token `Beta` with different signature.

3. Bob passes the token `Beta` to Alice. Alice is able to read the space 
    `My experiment`, but cannot modify any files. The space is accessed on 
    behalf of Bob - from the system's point of view, whoever bears the token is
    recognized as Bob. Cryptography ensures that it is computationally 
    implausible to infer token `Alpha` knowing only `Beta`. If Bob wishes to 
    publish his experiment data online, he can safely make the token `Beta` 
    public (see [safely publishing tokens](#safely-publishing-tokens)) - nobody 
    will be able to use it in other way than to read the `My experiment` data. 
    Bob can temporarily revoke or completely delete the token `Beta` at any 
    time, which will immediately disable the published token. 
    
4. In the meantime, Bob still uses the original token `Alpha` to write data in 
    the `My experiment` space, which becomes immediately visible for the users
    that have the `Beta` token.
    
The Onezone Web GUI offers a convenient wizard for adding caveats to tokens.
Further, you will find technical details and considerations about token caveats.

Below is the list of all recognized caveats in Onedata. Provided examples of 
caveats are in JSON format, recognized by the [REST API] (consult for more 
information about allowed values and usage). 

* `time` - limits the validity of the token to a certain point in time, 
    specified as an absolute timestamp in seconds (UNIX epoch). If no such 
    caveat is included in a token, it is valid infinitely. Note, however, that 
    temporary tokens **require** a time caveat, in contrary to named tokens. 
    ```json
    {
      "type": "time",
      "validUntil": 1571147494
    }
    ```
    
* `authorizationNone` - nullifies the authorization carried by the token. Such 
    token does not allow to perform any operation in the system, can be used 
    solely for identity verification. A token with such caveat can be referred to
    as an *identity token* (although any access token is a valid identity token).
    ```json
    {
      "type": "authorizationNone"
    }
    ```
    > NOTE: in tables that follow the `authorizationNone` is presented as always
    *rejected*, which is in fact how it works (nullifies the authorization 
    carried by the token).
    
* `audience` - limits the [audiences](#audience) that can utilize the token. If
    the caveat is present, the party that utilizes the token (bearer) must 
    include its access token in the `x-onedata-audience-token` header to prove 
    its identity. The audiences must be encoded using the proper 
    [audience format](#audience-types). If no such caveat is included in a token, 
    it can be used by any bearer.
    ```json
    {
        "type": "audience",
        "whitelist": [
            "usr-d4f5876dbe7f1e7e8a511de6dd31144c",
            "grp-0921135ee61fe53a3df449365228e9b4",
            "ozw-onezone",
            "ozp-onezone",
            "opw-01c4455bef059353c9dfb35ba93a24f3",
            "opp-01c4455bef059353c9dfb35ba93a24f3"
        ]
    }
    ```
    > NOTE: when adding `audience` caveats, keep in mind that if your requests 
    need to be proxied to another Oneprovider, it must also be whitelisted. 
    Proxying happens when the Oneprovider that you requested does not support 
    the concerned space.
    
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
    be proxied to another Oneprovider, its IP must also be whitelisted. Proxying
    happens when the Oneprovider that you requested does not support the 
    concerned space.
    
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
    > NOTE: as the client's ASN depends on client's IP, this caveat has the same
    considerations as the `ip` caveat when requests are proxied.
  
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
    > NOTE: as the client country depends on client's IP, this caveat has the same
    considerations as the `ip` caveat when requests are proxied.
    
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
    > NOTE: as the client region depends on client's IP, this caveat has the same
    considerations as the `ip` caveat when requests are proxied.
    
* `interface` - limits the available interfaces on which the token can be used 
    to a certain one - `rest`, `oneclient` or `graphsync`. If the `oneclient` 
    interface is specified, this caveat is treated as a
    [data access caveat](#data-access-caveats). The `graphsync` interface is
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
    includes the service identifier, operation type (CRUD) and resource 
    identifier. If no such caveat is included in a token, it can be used for all
    API calls.
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
    [data access caveat](#data-access-caveats). If no such caveat is included in 
    a token, it can be used for both reading and writing data.
    ```json
    {
      "type": "data.readonly"
    }
    ```

* `data.path` - limits the paths in which data can be accessed with the token.
    The paths must be canonical - starting with a slash + space id, and without 
    a trailing slash - and must be base64 encoded. If a directory path is given, 
    the token allows to access all nested files and directories starting from 
    the specified directory. This is a [data access caveat](#data-access-caveats). 
    If no such caveat is included in a token, it can be used for accessing all
    user files.
    ```json
    {
        "type": "data.path",
        "whitelist": [
            "L2QxYjM4OGY3Yzc=",
            "L2QxYjM4OGY3YzcvZGlyL2ZpbGUudHh0"
        ]
    }
    ```    
    ```
    "L2QxYjM4OGY3Yzc="                  ==  base64("/d1b388f7c7")
    "L2QxYjM4OGY3YzcvZGlyL2ZpbGUudHh0"  ==  base64("/d1b388f7c7/dir/file.txt")
    ```
    
* `data.objectid` - limits the object ids in which data can be accessed with the 
    token. The object ids comply with the CDMI format and can be used in the
    Oneprovider's REST and CDMI APIs. If a directory object id is given, the 
    token allows to access all nested files and directories starting from the 
    specified directory. This is a [data access caveat](#data-access-caveats).
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
    caveats - you should use the latter whenever possible for performance 
    reasons. Nevertheless, `data.objectid` have the advantage that they remain
    valid even if the target file is moved / renamed (given that the file id 
    does not change in the process) - contrary to `data.path` caveats.
    
    
Below table shows compatibility of caveats with access and invite tokens. Note 
that adding an unrecognized or incompatible caveat causes the token to always 
fail verification (renders it unusable in practice).

* <span style="color:#480"> allowed </span> - the caveat is recognized and will
    be checked against the request context
* <span style="color:red"> rejected </span> - presence of this caveat will cause
    immediate token verification failure

| Caveat            |               Access tokens               |               Invite tokens               |
|-------------------|:-----------------------------------------:|:-----------------------------------------:|
| time              | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| authorizationNone | <span style="color:red"> rejected </span> | <span style="color:red"> rejected </span> |
| audience          | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| ip                | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| asn               | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| geo.country       | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| geo.region        | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| interface         | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> |
| api               | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> |
| data.readonly     | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> |
| data.path         | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> |
| data.objectid     | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> |


### Data access caveats

*Data access caveats* are a special kind of caveat that carry additional, implicit
restrictions. Existence of **any data access caveat** in a token determines that 
the token is intended exclusively for accessing user files and causes all other 
APIs to be disallowed or limited to the minimum required to handle data access 
requests. Such tokens can only be used in the Oneprovider service for REST/CDMI
operations on files or mounting a Oneclient.

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
(see [safely publishing tokens](#safely-publishing-tokens)) - the token forbids 
any API operations and can be used solely to read the specified directory.

> These restrictions improve security, but the downside is that it is not 
possible to grant somebody restricted access to files and the system API at the 
same time with one token - two different tokens must be created.

The alternative would be to make no implicit restrictions and expect users to 
consciously limit the token with `api` caveats whenever they wish to safely 
publish it. That, however, was deemed too obscure, unintuitive and risky, as it 
would require a deep knowledge of the underlying mechanisms.


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

| Interface         |                    REST                    |                GraphSync[^1] (GUI)              |           GraphSync[^1] (Oneprovider)            |
|-------------------|:------------------------------------------:|:-----------------------------------------------:|:------------------------------------------------:|
| time              | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed        </span> | 
| authorizationNone | <span style="color:red">  rejected </span> | <span style="color:red">  rejected      </span> | <span style="color:red">  rejected       </span> | 
| audience          | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed        </span> | 
| ip                | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed        </span> | 
| asn               | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed        </span> | 
| geo.country       | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed        </span> | 
| geo.region        | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed        </span> | 
| interface[^2]     | <span style="color:#aa0"> `"rest"` </span> | <span style="color:#aa0"> `"graphsync"` </span> | <span style="color:#aa0"> restricted[^3] </span> |
| api               | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed        </span> | 
| data.readonly     | <span style="color:red">  rejected </span> | <span style="color:red">  rejected      </span> | <span style="color:#aa0"> restricted[^3] </span> |
| data.path         | <span style="color:red">  rejected </span> | <span style="color:red">  rejected      </span> | <span style="color:#aa0"> restricted[^3] </span> |
| data.objectid     | <span style="color:red">  rejected </span> | <span style="color:red">  rejected      </span> | <span style="color:#aa0"> restricted[^3] </span> |

[^1]: 
The GraphSync interface is used internally for communication between services 
and is not used directly by users, but is included in the table for reference.

[^2]: 
The interface caveat must match the interface on which the request has been 
made, as shown in the table. There is one exception - the Oneprovider GraphSync 
channel, where Onezone accepts all types of tokens that were delegated by users 
to Oneproviders, but the included caveats can impose further restrictions 
(e.g. when interface is equal to `"oneclient"`).

[^3]: 
Oneprovider service uses the GraphSync channel to fetch user data from Onezone. 
It uses the token that was passed to it by the user, either when he made a call
to the REST/CDMI API, mounted a Oneclient, or visited the Oneprovider GUI (which
utilizes a gui access token in the background). If the token contains any of the
*data access caveats*, Onezone will allow to fetch only the basic user info, 
necessary to handle the request, and block all other API operations. Even if the 
Oneprovider is malicious and somehow managed to trick the user into trusting it, 
it will not be able to cause any damage with such token.


#### Oneprovider

| Interface         |                    Oneclient                    |CDMI & REST<br/>(data access operations)[^1]|        REST<br/>(other operations)[^2]     |
|-------------------|:-----------------------------------------------:|:------------------------------------------:|:------------------------------------------:|
| time              | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed  </span> | 
| authorizationNone | <span style="color:red">  rejected </span>      | <span style="color:red">  rejected </span> | <span style="color:red">  rejected </span> | 
| audience          | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed  </span> | 
| ip                | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed  </span> | 
| asn               | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed  </span> | 
| geo.country       | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed  </span> | 
| geo.region        | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed  </span> | 
| interface         | <span style="color:#aa0"> `"oneclient"` </span> | <span style="color:#aa0"> `"rest"` </span> | <span style="color:#aa0"> `"rest"` </span> |
| api               | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed  </span> | <span style="color:#480"> allowed  </span> | 
| data.readonly     | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed  </span> | <span style="color:red">  rejected </span> |
| data.path         | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed  </span> | <span style="color:red">  rejected </span> |
| data.objectid     | <span style="color:#480"> allowed       </span> | <span style="color:#480"> allowed  </span> | <span style="color:red">  rejected </span> |

[^1]: 
Data access operations include the whole CDMI API and REST endpoints to manage
file and directory contents, metadata, permissions and ACLs. These endpoints
can be accessed with tokens that include a *data access caveat*.

[^2]: 
Other REST operations include the API for: shares, spaces, views, 
replicas & transfers, QoS, monitoring and datastore changes stream.
These endpoints are forbidden when the token includes a *data access caveat*.


#### Onepanel

| Interface         |             REST (Onezone panel)              |           REST (Oneprovider panel)            |
|-------------------|:---------------------------------------------:|:---------------------------------------------:|
| time              | <span style="color:#480"> allowed     </span> | <span style="color:#480"> allowed     </span> | 
| authorizationNone | <span style="color:red"> rejected     </span> | <span style="color:red"> rejected     </span> | 
| audience          | <span style="color:#480"> allowed     </span> | <span style="color:#480"> allowed     </span> | 
| ip                | <span style="color:#480"> allowed     </span> | <span style="color:red"> rejected[^1] </span> | 
| asn               | <span style="color:#480"> allowed     </span> | <span style="color:red"> rejected[^1] </span> | 
| geo.country       | <span style="color:#480"> allowed     </span> | <span style="color:red"> rejected[^1] </span> | 
| geo.region        | <span style="color:#480"> allowed     </span> | <span style="color:red"> rejected[^1] </span> | 
| interface         | <span style="color:red"> rejected[^2] </span> | <span style="color:red"> rejected[^2] </span> |
| api               | <span style="color:red"> rejected[^2] </span> | <span style="color:red"> rejected[^2] </span> | 
| data.readonly     | <span style="color:red"> rejected     </span> | <span style="color:red"> rejected     </span> |
| data.path         | <span style="color:red"> rejected     </span> | <span style="color:red"> rejected     </span> |
| data.objectid     | <span style="color:red"> rejected     </span> | <span style="color:red"> rejected     </span> |

[^1]:
Currently, only Onezone panel supports the IP related caveats (including 
ASN, country and region, which are checked using a GEO IP database). The 
support in Oneprovider panel is under implementation. For that time, tokens 
with such caveats are immediately rejected.

[^2]: 
Currently, the support for `api` and `interface` caveats in both Onepanels
is under implementation. For that time, tokens with such caveats are immediately 
rejected.


## Audience

Audience is the party that consumes the token in the context of a request. 
Consider Bob, who uses his token to access the Oneprovider API - in this case, 
the requested Oneprovider service is the audience. When verifying the token, 
Onezone checks if the token allows the audience, and only then authorizes the 
request. If the token has no `audience` caveats, any audience is allowed, 
otherwise the request's audience must be whitelisted.

Bob can issue a token with an `audience` caveat that says that only Alice can
consume the token. In such case, Alice has to prove her identity by adding her
[audience token](#audience-tokens) to the request:
```bash
~$ curl -H "x-auth-token: ${BOBS_ACCESS_TOKEN}" \
        -H "x-onedata-audience-token: ${ALICES_ACCESS_TOKEN}" \
        -X GET ...
```

If Alice performs such request to a Oneprovider service, the request is
considered to have two audiences: the Oneprovider and Alice. In such case,
both audiences must be whitelisted in `audience` caveats (if any) for the
request to be authorized.


### Audience tokens

Audience tokens are regular access tokens, but with restricted range of allowed
caveats, as shown in the table that follows. In the above example, Alice could
use any of her own access tokens that do not include disallowed caveats.

| Caveat            |               Access tokens               |               Audience tokens             |
|-------------------|:-----------------------------------------:|:-----------------------------------------:|
| time              | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| authorizationNone | <span style="color:red"> rejected </span> | <span style="color:red"> rejected </span> |
| audience          | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> |
| ip                | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| asn               | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| geo.country       | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| geo.region        | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| interface         | <span style="color:#480"> allowed </span> | <span style="color:#480"> allowed </span> |
| api               | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> |
| data.readonly     | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> |
| data.path         | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> |
| data.objectid     | <span style="color:#480"> allowed </span> | <span style="color:red"> rejected </span> |


### Audience types

There are 6 audience types in Onedata. Note the serialized format in the table
below if you wish to use the [REST API] for creating tokens with `audience` 
caveats - the first three letters denote the type, and the rest after the
hyphen is the `id` of the corresponding user / group / Oneprovider (or special
`onezone` keyword for the Onezone service). 

| Audience                       |               Examples (serialized format)              | 
|--------------------------------|:-------------------------------------------------------:|
| user                           | `usr-d4f5876dbe7f1e7e8a511de6dd31144c` <br/> `usr-*`    |
| group                          | `grp-0921135ee61fe53a3df449365228e9b4` <br/> `grp-*`    |
| Onezone                        | `ozw-onezone`                                           |
| Onezone panel (for admins)     | `ozp-onezone`                                           |
| Oneprovider                    | `opw-01c4455bef059353c9dfb35ba93a24f3` <br/> `opw-*`    |
| Oneprovider panel (for admins) | `opp-01c4455bef059353c9dfb35ba93a24f3` <br/> `opp-*`    |

> Note: group audience is a special audience that can be put into the `audience`
caveat's whitelist. It will be successfully verified if the request's audience
is a user that belongs to the specified group.

> Note: the special `*` audience `id` can be used to allow any audience of given
type (e.g. any user or any Oneprovider).


In the previous example with Bob and Alice, Bob's token would have the following
caveat:

```json
{
    "type": "audience",
    "whitelist": [
        "usr-5c9dfb35db55bef7e8a51dfb35ba93a2",
        "opw-228e9ba93ab4b3a3d353c9dfb35ba93a"
    ]
}
```
* `5c9dfb35db55bef7e8a51dfb35ba93a2` - Alice's user `id`
* `228e9ba93ab4b3a3d353c9dfb35ba93a` - Oneprovider's `id`


### Request audiences in different services

Below table shows all possible request audiences depending on the service that
was requested and if the client used an access token alone or along with an 
audience token. 

| Tokens sent           | access token  | access token & audience token of user `abcd` |
|-----------------------|:-------------:|:--------------------------------------------:|
| Onezone               | `ozw-onezone` | `ozw-onezone` & `usr-abcd`                   |
| Onezone panel         | `ozp-onezone` | `ozp-oenzone` & `usr-abcd`                   |
| Oneprovider           | `opw-provId`  | `opw-provId` & `usr-abcd`                    |
| Oneprovider panel     | `opp-provId`  | `opp-provId` & `usr-abcd`                    |

The access token must allow the above audiences for the request to be
authorized; in other words, eligible access tokens are:
* a token without any `audience` caveats
* a token in which all `audience` caveats whitelist all the above audiences.

  
## Safely publishing tokens

It is possible to create a token with very limited rights and safely publish it
online so anyone can use it to access user's resources. Nevertheless, it must 
always be done with great care, as the bearer of the token can perform 
operations on behalf of the issuing subject. If the published token is too open, 
anyone might be able to tinker with user's account and data.

When creating a token for public use, consider the following:

* Make sure to include carefully chosen [data access caveats](#data-access-caveats) 
in the token (`data_readonly`, `data_path`, `data_objectid`). In a typical scenario, 
you may want to allow readonly access to a certain subset of your data. In rare 
cases, you can use an `api` caveat to enable a very specific API operation 
that you want to be publicly available in your name. Remember than `api` and
*data access caveats* [do not go together](#data-access-caveats).

* It may be reasonable to use an `interface` caveat and specify the interface
on which the token will be exclusively accepted. For example, if `oneclient`
interface is specified, the token bearer will not be able to perform any API
operations via REST, which increases security.

* Consider using `audience` caveats to limit the available consumers of the 
token to certain Oneproviders or users.

* Make sure to create a `named` token to be able to revoke or delete it at any 
time.


## Security and privacy considerations

Here are some technical details concerning the security and privacy when using
or delegating access tokens:

* You should always keep your tokens safe, just like you would do with your
passwords or certificates / private keys. The exceptions are 1) when passing an 
invite token to somebody you wish to invite or 2) when delegating an access 
token that has been properly limited by caveats.

* When a Oneprovider or Oneprovider panel service is requested using an access 
token, it is required that the Oneprovider supports the token's subject user, 
otherwise authorization is declined. This is checked by Onezone when releasing 
user data. It is not possible to utilize the token in an untrusted Oneprovider,
 which protects from data exfiltration.

* Tokens with [data access caveats](#data-access-caveats) can be used solely on 
Oneprovider interfaces (oneclient / REST / CDMI). When using such token, the 
bearer is not able to learn any of subject's data. The data is processed by the 
Oneprovider to handle the request, but never disclosed to the client. As stated 
in previous point, the Oneprovider must be supporting the subject user, which 
implies that it is trusted.

* *Data access caveats* [implicitly limit the available APIs](#data-access-caveats)
to a minimum so that the token bearer cannot perform any modifications to 
subject's account or read private information.

* `data_path` and `data_objectid` caveats imply in which spaces the token can be
used - other spaces are completely invisible and inaccessible to the token bearer.


[Google's macaroons]: https://ai.google/research/pubs/pub41892
[REST API]: https://onedata.org/#/home/api/latest/onezone?anchor=tag/Token