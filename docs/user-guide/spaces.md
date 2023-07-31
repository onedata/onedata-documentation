# Spaces

Spaces are a fundamental concept of user data organization in Onedata. A **space**
can be perceived as a logical container for data — a layer that hides the complexity
of different storage systems and the physical location of files. It offers
a unified storage space in the Onedata virtual file system, where files and
directories are referenced by [logical paths or global IDs](data.md#file-path-and-id).
Each space can have multiple [members](#space-members) — users or groups.
Only the members of a space have access to the stored data.

## Space support

A space is merely a logical container that requires at least one physical
[storage](../admin-guide/oneprovider/configuration/storages.md)
backend attached to be functional. Attaching a physical storage is
called **supporting** the space and is done by a data provider -
institution that entered the Onedata environment by configuring a
[Oneprovider service](../intro.md#architecture) for managing access to its
storage resources. Users can request support for their spaces, and provider
admins can decide to grant some quota on a physical storage governed by the
corresponding data center.

<!-- TODO VFS-7218 this image could be better:
    1. present providers, not only storages
    2. present the mapping between logical and physical paths
       (file path on the storage vs. file path in the space)

 -->

![image](../../images/user-guide/spaces/space-support.svg)

Each space may be supported by one or more providers and the data produced by
the space users will be distributed among the assigned storages. Users do not
need to be aware of the physical distribution of the data to use the platform,
as all the files are visible in a unified logical space and universally
available under the logical paths and global IDs. However, understanding how
the distribution works and consciously managing it can greatly improve the
performance of data access, e.g. by pre-staging data sets in the provider
in which computations are to be performed. There are several tools in Onedata
that can be used by advanced users to manage the underlying physical distribution
and redundancy of data (such as [data transfers](replication-and-migration.md)
or [QoS](quality-of-service.md)).

When a file within a space is written (e.g. uploaded), its content is written to
one of the supporting physical storages. Similarly, during a file read, the
physical data is read from the storage and then returned to the requesting client.
Onedata stores information about the mapping between logical and physical files
in the file metadata, which is replicated and synchronized between
all supporting providers.

<!-- TODO VFS-9288 globally unify the formatting of NOTEs in all docs -->

> **NOTE**: a space can be supported with an imported storage.
> This way, a preexisting data-set can be made available in a Onedata space.
> Learn more [here](../admin-guide/oneprovider/configuration/storage-import.md).

## Space members

Access control to Onedata spaces is built around the concept of user and group
memberships. A space is accessible only to its members — in a typical scenario,
this can be a group of scientists that work on the same research project and
share the related datasets. They may have different affiliations, but their view
on the common space is the same, regardless of their institution of origin. Each
user or group can be assigned different privileges in the space, depending on
the capabilities they should have. In case of group memberships, each member of
a group that belongs to a space inherits the group's privileges. For example,
one may create a group called **space XYZ admins** and grant it all admin
privileges in the **space XYZ**. Any user that is added to the group will inherit
the privileges and gain access to the **space XYZ** with admin privileges.

## Space privileges

<!-- TODO VFS-7218 section about privileges -->

## Space owner

<!-- TODO VFS-7218 documentation for space owner concept -->

## GUI guide
Below is a step-by-step tutorial that will guide you through creating and
managing spaces.

### Create or join a new space
Navigate to the **DATA** tab to create your first space. You may also join an
existing space using the **Consume** action in the
[Tokens GUI](tokens.md#consuming-invite-tokens), in case you
received an invite token from another user.
For this tutorial, create a space and give it a name of your choice.
![image](../../images/user-guide/spaces/1-no_spaces.png#screenshot)

### Request support for space

In order to request support for your space, click on the **PROVIDERS** tile
in the overview, which will invoke the **Add support** action. Alternatively,
navigate to the space's **Providers** submenu.
![image](../../images/user-guide/spaces/2-space_created.png#screenshot)

You should obtain a space support token — pass it to a provider admin so that
they can [grant support for your space](../admin-guide/oneprovider/configuration/space-support.md#granting-space-support).
The token is multi-use and valid for a day.
![image](../../images/user-guide/spaces/3-request_support.png#screenshot)

After the support is granted, you will see that the new provider has
appeared and a certain quota has been assigned.
![image](../../images/user-guide/spaces/4-space_overview.png#screenshot)

### Invite a user

Navigate to the **Members** submenu. Here, you can manage the users and
groups that belong to the space. To invite a new user, you would click on the
token generation action, copy the acquired token and pass it to another user.
![image](../../images/user-guide/spaces/5-members.png#screenshot)

### Invite a group
Create a new group using the `(+)` action button in the **GROUPS** menu.
Name the group **Space admins**.
![image](../../images/user-guide/spaces/6-create-group.png#screenshot)

Go back to the space menu (**DATA** tab -> **Space name** -> **Members**) and
generate a group invite token. Copy it to the clipboard for the next step.
![image](../../images/user-guide/spaces/7-create-group-invite-token.png#screenshot)

Use the the **Consume** action in the [Tokens GUI](tokens.md#consuming-invite-tokens).
Paste in the token — it will be identified and you will be asked which group you
wish to add. Choose the **Space admins** group and confirm.

### Modify space privileges

When the **Space admins** group has been added to the space, go back to the
members menu, where you can view its privileges by expanding the entry.
![image](../../images/user-guide/spaces/8-privileges-1.png#screenshot)

The privileges are grouped into sections — you can grant or revoke the whole
section, or expand for more granular setting. Make sure to save your changes
afterwards.
![image](../../images/user-guide/spaces/9-privileges-2.png#screenshot)

### Add your group

For the sake of this tutorial, you have added your own group using a token.
In real scenarios, you would pass the invite token to another user, who would be
able to join with one of their groups. There is an easier way of adding groups -
familiarize with the **Create new group** and **Add one of your groups** actions.
Create and add **Other group** to the space using one of those methods.
![image](../../images/user-guide/spaces/10-add-your-group.png#screenshot)

### Bulk edit of privileges
You can use the **Bulk edit** action after selecting several groups and/or
users to update the privileges for all of them at once. The new settings will
overwrite the old ones to identical values.
![image](../../images/user-guide/spaces/11-bulk-edit.png#screenshot)

### Effective members

Navigate to the **GROUPS** menu and create a subgroup for the **Other group**.
The interface is analogical to the one for spaces.
![image](../../images/user-guide/spaces/12-subgroup.png#screenshot)

Go back to the space members view. Expand the view options and choose
**Effective Privileges**. You will see that the Subgroup appears on the list.
This is because it inherits the space membership in the space from its parent
group — **Other group**. Examine the privileges and see that they are inherited
as well. You can play around with the privileges of the **Other group** and see
that the inheritance is updated.
![image](../../images/user-guide/spaces/13-effective-privileges.png#screenshot)

Switch to the **Effective Memberships** view, and optionally turn on
descriptions. Expand your user entry to see all of your memberships in the
space — direct and inherited from group memberships (effective).
![image](../../images/user-guide/spaces/14-effective-memberships.png#screenshot)

### Data browser

Go to the **Data** submenu in your space to navigate to the file browser.
Refer to the [Web file browser](web-file-browser.md) guide for further instructions.
![image](../../images/user-guide/spaces/15-data.png#screenshot)
