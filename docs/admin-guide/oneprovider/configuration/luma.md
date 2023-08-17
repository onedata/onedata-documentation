# Local User Mapping — LUMA

[toc][1]

## Overview

LUMA is a database that stores mappings between Onedata user accounts and local user accounts/credentials on storage
resources, e.g.:

* POSIX UID/GID
* Ceph username and password
* GlusterFS UID/GID

LUMA DB essentially establishes a relation between members of a Onedata space and user accounts recognized by different
storage providers, reflecting the ownerships of user data kept on various storage systems in different locations.
The LUMA DB can be set up for each storage registered in Oneprovider separately, with different credentials for users on
each storage.

In order to understand LUMA DB and how mappings should be defined, consult the
[POSIX-like file ownership and permissions][2] section.

## Storage and LUMA essentials

**Below checklist contains the fundamental steps to properly configure your storage and the LUMA DB.**
Nonetheless, it is recommended that you first familiarize yourself with all the concepts described in this chapter.

### Checklist for regular (non-imported) storages

1. Choose the right [LUMA DB feed][3].
2. Substantiate the [required mappings][4] (if applicable).
3. Make sure that [storage credentials][5] to which Onedata users will be
   mapped exist and are reflected in the storage system.

### Checklist for imported storages

1. Choose the right [LUMA DB feed][3].
2. Substantiate the [required mappings][4] (if applicable) .
3. Make sure that [storage credentials][5] to which Onedata users will be
   mapped exist and are reflected in the storage system.
4. As far as possible, ensure that all files on the *imported storage* have the same group owner (GID) — [read more][6].
5. If you intend to enable [*auto storage import*][7] with enabled `Synchronize ACL` option
   you must properly configure the chosen LUMA feed to deliver mappings for NFSv4 ACL
   [users][8] and [groups][9]
   for which ACLs are set on the *imported storage*.

## Configuration

Configuration of LUMA DB is part of a [storage configuration][10].

It is possible to choose the type of [feed][3] for populating the DB.
In case of selecting the [external feed][11], it is compulsory to set URL of the external server that
will be lazily queried to populate the LUMA DB.
It is also possible to set an API key that will be send with each request to the external server.
Example configuration of LUMA feed is presented on the below picture:

![screen-12][]

> **NOTE:**  Modification of the type of feed for LUMA DB results in automatic deletion of all entries in the LUMA DB for
> given storage resource. Newly set feed will be used to populate LUMA DB once again.

> **WARNING:**  Clearing the LUMA DB when feed type is changed means that the local feed is also cleared. In order to use
> the local feed then, all mappings must be added once again.

## Credential types

These definitions are used throughout the rest of the chapter.

### Storage credentials

Credentials relevant for corresponding storage backend, used to perform operations on the storage in context of a specific user.

### Display credentials

Credentials used to present POSIX credentials (UID & GID) of a file owner in the
file's attributes, e.g., they are displayed in the result of `ls` operation in Oneclient or when fetching file
attributes using REST API.

### Onedata user credentials

Credentials identifying a user in the Onedata system.

### Onedata group credentials

Credentials identifying a group in the Onedata system.

## Database

LUMA DB consists of 5 tables that store 4 types of records, as described below.

### Tables

| Table                         | Key                        | Record                   |
| ----------------------------- | -------------------------- | ------------------------ |
| Storage users                 | `(StorageId, UserId)`      | [`StorageUser`][13]      |
| Spaces posix storage defaults | `(StorageId, SpaceId)`     | [`PosixCredentials`][14] |
| Spaces display defaults       | `(StorageId, SpaceId)`     | [`PosixCredentials`][14] |
| Onedata users                 | `(StorageId, UID/AclUser)` | [`OnedataUser`][15]      |
| Onedata groups                | `(StorageId, AclGroup)`    | [`OnedataGroup`][16]     |

### Records

#### `StorageUser`

This record is used to represent user on the specific storage backend and consists of two fields:

* `storageCredentials` is a map storing credentials relevant for given storage backend,
* `displayUid` is a field used to present corresponding user as owner of a file (UID) in Oneclient or GUI

```JSON
{
    "storageCredentials": JSON, // Map storing credentials relevant for given storage backend
    "displayUid": Integer
}
```

#### `PosixCredentials`

This record stores standard POSIX-like user ID and group ID.

```JSON
{
    "uid": Integer,
    "gid": Integer
}
```

#### `OnedataUser`

These record represents credentials identifying a user in the Onedata system.
The record has one of the two schemes:

* `"onedataUser"` — user's ID is stored directly in the record
* `"idpUser"` — the record stores ID of an external identity provider (Idp) and ID of the user understood by the Idp

```JSON
{
    "mappingScheme": "onedataUser" | "idpUser",
    // fields for "onedataUser" scheme
    "onedataUserId": String,     
    // fields for "idpUser" scheme
    "idp": String,
    "subjectId": String
}
```

For more information on mapping users from external Idp to Onedata users, see
[here][17].

#### `OnedataGroup`

These record represents credentials identifying a group in the Onedata system.
The record has one of the two schemes:

* `"onedataGroup"` — group's ID is stored directly in the record
* `"idpEntitlement"` — the record stores ID of an external identity provider (Idp) and ID of the group understood by the Idp

```JSON
{
    "mappingScheme": "onedataGroup" | "idpEntitlement",
    // fields for "onedataGroup" scheme
    "onedataGroupId": String,
    // fields for "idpEntitlement" scheme
    "idp": String,
    "idpEntitlement": String
}
```

For more information on mapping groups from external Idp to Onedata groups, see
[here][18].

## LUMA mappings

The mappings that need to be provided are different for regular and [*imported storages*][19], as shown below. Instructions how
to populate the LUMA DB with required mappings can be found in the [next section][3].

### Regular (non-imported) storages

If the [*storage import*][20] is disabled, LUMA is used to access the storage in the user's context and it is sufficient to provide
the [storage credentials][21] mapping and recommended to set the default space GID in case of POSIX
storage (see below). The [display credentials][22] are optional — LUMA will use defaults if not provided.

#### Onedata user to storage credentials mapping

[Storage credentials][21] are acquired differently depending on the storage type.

On POSIX incompatible storages, field `storageCredentials` from [`StorageUser`][13] record stored in
[Storage users table][23] is basically returned.

On POSIX compatible storages (currently POSIX, GLUSTERFS, NULLDEVICE), credentials consist of 2 integers: UID and GID.
Only UID field is stored in the [`StorageUser`][13] record, the GID is constant for the space
(all space members are treated as the owner group — [read more][2]).
This strategy ensures that all files created in the space have the same GID owner on the supporting storage so that
ownership of the files in the space is correctly mapped on the storage.

Due to above reasons, GID is acquired from field `gid` from [`PosixCredentials`][14]
record stored in [Spaces posix storage defaults table][23].

> **NOTE:** To enable use of [Oneclient in direct-io mode][24]
> for all space users, the storage admin has to ensure that:
>
> * LUMA properly maps each Onedata user to an UID that is recognized in the system hosting the storage
> * There exists a group in the system hosting the storage with GID equal to the virtual space GID
>   ([read more][2]), and all above-mentioned UIDs belong to the group

#### Onedata user to display credentials mapping

[Display credentials][22] are POSIX compatible credentials that consist of 2 integers: UID and GID.

UID is acquired from field `displayUid` from [`StorageUser`][13] record stored in [Storage users table][23].

GID is acquired from field `gid` from [`PosixCredentials`][14] record stored in [Spaces display defaults table][23].

### Imported storages

Below mappings are associated with the concept of [*storage import*][20]
and should only be considered when the corresponding storage is an [*imported storage*][19].

* mapping storage user to [Onedata user][25] — used in case of importing files from storage.
  It allows mapping owner of the storage file to a specific Onedata user who will become owner of the file imported
  to the space. Storage user is identified by the value of UID field returned from `stat` operation or equivalent on
  given storage backend.
* mapping storage NFSv4 ACL principal to Onedata [user][25]/[group][26] —
  used in case of importing files from storage that supports [NFSv4 ACLs][27],
  with `Synchronize ACL` option enabled. It allows mapping ACL principal to a specific user/group in the Onedata. If `Synchronize ACL`
  option is disabled this mapping does not have to be defined.

> **WARNING:** It is possible that imported files have different GIDs. Oneprovider does not attempt to map them to the
> Onedata groups model as it's not compatible with the POSIX groups model. It is strongly recommended that admin of the
> legacy storage to be imported ensures that the file structure is compliant with the Onedata model — all files in the
> space should have the same group owner. **Otherwise, access to imported files may be denied by the underlying storage system.**

#### Storage user to Onedata user mapping

UID returned from `stat` operation or equivalent on given storage backend is mapped to [`OnedataUser`][15] record
stored in the [Onedata users table][23]. Information stored in the record allow identifying corresponding Onedata user.
If the mapping is not defined, virtual space user becomes owner of the imported file.

> **NOTE:** This mapping is used only in case of enabled [*auto storage import*][7].

#### Storage ACL user to Onedata user mapping

ACL principal is mapped to [`OnedataUser`][15] record stored in the [Onedata users table][23].
Information stored in the record allow identifying corresponding Onedata user.
If the mapping is not defined, importing the file will return an error.

> **NOTE:** This mapping is used only in case of enabled [*auto storage import*][7]
> with `Synchronize ACL` option enabled.

#### Storage ACL group to Onedata group mapping

ACL group principal is mapped to [`OnedataGroup`][16] record stored in the [Onedata groups table][23].
Information stored in the record allow identifying corresponding Onedata group.
If the mapping is not defined, importing the file will return an error.

> **NOTE:** This mapping is used only in case of enabled [*auto storage import*][7]
> with `Synchronize ACL` option enabled.

## Populating LUMA DB with feeds

LUMA DB can be filled with mappings in 3 different ways, called feeds:

* [`auto`][28]
* [`local`][29]
* [`external`][11]

### Auto Feed

Auto feed populates LUMA DB using an automatic algorithm.
This sections describes the algorithm for each [table][23].

> **NOTE:**  If you want to fully configure LUMA DB for efficient and secure storage access
> you should choose local or external feeds. Auto feed is meant to be used at the very beginning of
> learning how to maintain Oneprovider service to ease the process of the first deployment.

#### Auto feed for Storage users table

This table is populated differently depending on the storage type for which it is configured.
In case of POSIX compatible storages, UID is generated basing on the Onedata user ID.

> **NOTE:** Using the auto feed on POSIX compatible storages can make it impossible to use
> [Oneclient in direct-io mode][24], as the automatically
> generated mappings will not correspond to actual UIDs/GIDs recognized by the storage system.

The same UID is used as user's `displayUid`.

In case of POSIX incompatible storages, storage credentials of the storage admin are used as user's storage credentials.

> **WARNING:**  Allowing all space members to access storage with admin credentials is a potential security risk.
> Therefore, using the auto feed is not recommended for POSIX incompatible storages.

`displayUid` is generated the same way as UID in case of POSIX compatible storage.

#### Auto feed for Spaces posix storage defaults table

This table is populated only for POSIX compatible storages.
UID and GID of owner of the storage mountpoint are used, as returned by the `stat` operation.

#### Auto feed for Spaces display defaults table

This table is populated differently depending on the storage type for which it is configured.
In case of POSIX compatible storages, the same credentials as stored in [Spaces posix storage defaults table][23] are used.

In case of POSIX incompatible storages, UID and GID are generated basing on the ID of the space for which the table is populated.

#### Auto feed for Onedata users table

This table can be populated automatically only with entries that associate storage user, identified by UID with Onedata user.
Entries for NFSv4 ACL users cannot be populated automatically, they can only by populated by [local][29] or
[external][11] feeds. The table is used only in case of [*auto storage import*][7]
enabled. Moreover, mappings for NFSv4 ACL users are used
only if `Synchronize ACL` option is enabled.

#### Auto feed for Onedata groups table

This table cannot be populated automatically, it can only be populated by [local][29] or [external][11]
feeds. The table is used only in case of case of [*auto storage import*][7]
enabled with `Synchronize ACL` option enabled.

### Local Feed

All mappings in LUMA DB must be set explicitly by the Oneprovider admin using the REST API.
It is recommended to set the mappings before inviting users to join the space, otherwise their operations on files will fail.

Comprehensive description of requests and their parameters considering configuration of local feed
can be found in the [REST API documentation][30].

> **NOTE:**  For [regular (non-imported) storages][31], it is enough to set the
> [Onedata user to credentials mappings][5].
> Other mappings, if not set, are acquired the same way it is done in case of auto feed.

> **WARNING:**  In case of local feed, mappings are directly stored in the LUMA DB tables.
> Deleting entries from the local feed results in deleting them from the LUMA DB and vice versa.

| Request                                                    | Link to API |
| ---------------------------------------------------------- | ----------- |
| Lookup Onedata user to credentials mapping in local feed   | [API][32]   |
| Remove Onedata user to credentials mapping in local feed   | [API][33]   |
| Insert Onedata user to credentials mapping into local feed | [API][34]   |
| Modify Onedata user to credentials mapping in local feed   | [API][35]   |
| Lookup default display credentials in local feed           | [API][36]   |
| Remove default display credentials in local feed           | [API][37]   |
| Insert default display credentials into local feed         | [API][38]   |
| Lookup default posix credentials in local feed             | [API][39]   |
| Remove default posix credentials in local feed             | [API][40]   |
| Insert default posix credentials into local feed           | [API][41]   |
| Lookup mapping of UID in local feed                        | [API][42]   |
| Remove mapping of UID in local feed                        | [API][43]   |
| Insert mapping of UID into local feed                      | [API][44]   |
| Lookup mapping of ACL user in local feed                   | [API][45]   |
| Remove mapping of ACL user in local feed                   | [API][46]   |
| Insert mapping of ACL user into local feed                 | [API][47]   |
| Lookup mapping of ACL group in local feed                  | [API][48]   |
| Remove mapping of ACL group in local feed                  | [API][49]   |
| Insert mapping of ACL group into local feed                | [API][50]   |

### External Feed

The LUMA DB is populated by lazily querying an external HTTP server that implements a standardized API.
The space admin is responsible for the implementation and maintenance of the server.

> **NOTE:**  It is compulsory to configure the URL of external feed —  see the [Configuration][51] section.

Below is the full API specification of the external LUMA feed server.

> **NOTE:**  For [regular (non-imported) storages][31], it is enough to implement callback
> for acquiring [Onedata user to credentials mappings][52].
> Other mappings, if not set, are acquired the same way it is done in case of auto feed.

#### Endpoint for mapping Onedata user to storage credentials

* URL: `/storage_access/all/onedata_user_to_credentials`
* HTTP method: `POST`
* accepted body:

```json
{
    "storageId": String,         // guaranteed
    "onedataUserId": String,     // guaranteed,
    "idpIdentities": [{          // guaranteed
        "idp": String,
        "subjectId": String,
    }],
    "additionalUserDetails": {   // best effort, can be empty
        "id": String,
        "username": String,
        "emails": [String],
        "linkedAccounts": [
            "idp": String,
            "subjectId": String,
            "username": String,
            "emails": [String],
            "custom": JSON       
        ]
    }
}
```

* response body: [`StorageUser`][13]

```json
{
    "storageCredentials": StorageCredentials, // required
    "displayUid": Integer                     // optional
}
```

For more information on mapping users from external Idp to Onedata users, see
[here][17].

#### Endpoint for setting default POSIX storage credentials in the space

* URL: `/storage_access/posix_compatible/default_credentials`
* HTTP method: `POST`
* accepted body:

```json
{
    "storageId": String,    // guaranteed
    "spaceId": String       // guaranteed
}
```

* response body: [`PosixCredentials`][14]

```json
{
    "uid": Integer,         // optional
    "gid": Integer          // optional
}
```

#### Endpoint for setting default space display credentials in the space

* URL: `/display_credentials/default`
* HTTP method: `POST`
* accepted body:

```json
{
    "storageId": String,    // guaranteed
    "spaceId": String       // guaranteed
}
```

* response body: [`PosixCredentials`][14]

```json
{
    "uid": Integer,          // optional
    "gid": Integer           // optional
}
```

#### Endpoint for mapping storage UID to Onedata user

* URL: `/storage_import/posix_compatible/uid_to_onedata_user`
* HTTP method: `POST`
* accepted body:

```json
{
    "storageId": String,    // guaranteed
    "uid": Integer          // guaranteed
}
```

* response body: [`OnedataUser`][15]

```JSON
{
    "mappingScheme": "onedataUser" | "idpUser", // required
    // fields for "onedataUser" scheme
    "onedataUserId": String,                    // required if mappingScheme == "onedataUser"
    // fields for "idpUser" scheme
    "idp": String,                              // required if mappingScheme == "idpUser"
    "subjectId": String                         // required if mappingScheme == "idpUser"
}
```

#### Endpoint for mapping NFSv4 ACL user principal to Onedata user

* URL: `/storage_import/posix_compatible/acl_user_to_onedata_user`
* HTTP method: `POST`
* accepted body:

```json
{
    "storageId": String,    // guaranteed
    "aclUser": String       // guaranteed
}
```

* response body: [`OnedataUser`][15]

```JSON
{
    "mappingScheme": "onedataUser" | "idpUser", // required
    // fields for "onedataUser" scheme
    "onedataUserId": String,                    // required if mappingScheme == "onedataUser"
    // fields for "idpUser" scheme
    "idp": String,                              // required if mappingScheme == "idpUser"
    "subjectId": String                         // required if mappingScheme == "idpUser"
}
```

#### Endpoint for mapping NFSv4 ACL group principal to Onedata group

* URL: `/storage_import/posix_compatible/acl_group_to_onedata_group`
* HTTP method: `POST`
* accepted body:

```json
{
    "storageId": String,    // guaranteed
    "aclGroup": String      // guaranteed
}
```

* response body: [`OnedataGroup`][16]

```JSON
{
    "mappingScheme": "onedataGroup" | "idpEntitlement", // required
    // fields for "onedataGroup" scheme
"onedataGroupId": String,                               // required if mappingScheme == "onedataGroup"
    // fields for "idpEntitlement" scheme
    "idp": String,                                      // required if mappingScheme == "idpEntitlement"
    "idpEntitlement": String                            // required if mappingScheme == "idpEntitlement"
}
```

## REST API

LUMA DB exposes [REST API][53] which allows to
get its configuration and also lookup/delete entries in the database.
Links to comprehensive description of requests are presented in the below table:

> **NOTE:**  Deleted mapping from LUMA DB will be acquired from the currently set feed when needed.
> Please remember that deleting an entry from the LUMA DB in case of local feed results also in deleting
> it from the feed.

| Request                                    | Link to API |
| ------------------------------------------ | ----------- |
| Get LUMA DB configuration                  | [API][54]   |
| Clear LUMA DB                              | [API][55]   |
| Lookup default display credentials         | [API][56]   |
| Remove default display credentials         | [API][57]   |
| Lookup Onedata user to credentials mapping | [API][58]   |
| Remove Onedata user to credentials mapping | [API][59]   |
| Lookup default posix credentials           | [API][60]   |
| Remove default posix credentials           | [API][61]   |
| Lookup mapping of UID                      | [API][62]   |
| Remove mapping of UID                      | [API][63]   |
| Lookup mapping of ACL user                 | [API][64]   |
| Remove mapping of ACL user                 | [API][65]   |
| Lookup mapping of ACL group                | [API][66]   |
| Remove mapping of ACL group                | [API][67]   |

[1]: <>

[2]: ../../../user-guide/data.md#posix-permissions

[3]: #populating-luma-db-with-feeds

[4]: #luma-mappings

[5]: #onedata-user-to-storage-credentials-mapping

[6]: #imported-storages

[7]: storage-import.md#auto-storage-import

[8]: #storage-acl-user-to-onedata-user-mapping

[9]: #storage-acl-group-to-onedata-group-mapping

[10]: storages.md#configuration

[11]: #external-feed

[screen-12]: ../../../../images/admin-guide/oneprovider/configuration/luma/luma_config.png

[13]: #storageuser

[14]: #posixcredentials

[15]: #onedatauser

[16]: #onedatagroup

[17]: ../../onezone/configuration/oidc-saml.md#attribute-mapping

[18]: ../../onezone/configuration/oidc-saml.md#entitlement-mapping

[19]: storages.md#imported-storage

[20]: storage-import.md

[21]: #storage-credentials

[22]: #display-credentials

[23]: #tables

[24]: ../../../user-guide/oneclient.md#direct-io-and-proxy-io-modes

[25]: #onedata-user-credentials

[26]: #onedata-group-credentials

[27]: https://www.osc.edu/book/export/html/4523

[28]: #auto-feed

[29]: #local-feed

[30]: https://onedata.org/#/home/api/stable/onepanel?anchor=tag/LUMA-DB-local-feed

[31]: #regular-non-imported-storages

[32]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_get_onedata_user_to_credentials_mapping

[33]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_remove_onedata_user_to_credentials_mapping

[34]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_add_onedata_user_to_credentials_mapping

[35]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_modify_onedata_user_to_credentials_mapping

[36]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_get_display_credentials

[37]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_remove_display_credentials

[38]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_set_display_credentials

[39]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_get_default_posix_credentials

[40]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_remove_default_posix_credentials

[41]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_set_default_posix_credentials

[42]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_get_UID_to_onedata_user_mapping

[43]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_remove_UID_to_onedata_user_mapping

[44]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_set_UID_to_onedata_user_mapping

[45]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_get_acl_user_to_onedata_user_mapping

[46]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_remove_acl_user_to_onedata_user_mapping

[47]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_set_acl_user_to_onedata_user_mapping

[48]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_get_acl_group_to_onedata_group_mapping

[49]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_remove_acl_group_to_onedata_group_mapping

[50]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/local_feed_set_acl_group_to_onedata_group_mapping

[51]: #configuration

[52]: #endpoint-for-mapping-onedata-user-to-storage-credentials

[53]: https://onedata.org/#/home/api/stable/onepanel?anchor=tag/LUMA-DB

[54]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_get_config

[55]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_clear_db

[56]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_get_display_credentials

[57]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_remove_display_credentials

[58]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_get_onedata_user_to_credentials_mapping

[59]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_remove_onedata_user_to_credentials_mapping

[60]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_get_default_posix_credentials

[61]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_remove_default_posix_credentials

[62]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_get_UID_to_onedata_user_mapping

[63]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_remove_UID_to_onedata_user_mapping

[64]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_get_acl_user_to_onedata_user_mapping

[65]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_remove_acl_user_to_onedata_user_mapping

[66]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_get_acl_group_to_onedata_group_mapping

[67]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_remove_acl_group_to_onedata_group_mapping
