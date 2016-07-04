

# LUMA - Local User MApping

Luma is a Onedata service that allows custom mapping between local user accounts or credential on storage resources (e.g. POSIX user ID/group ID, LDAP DN, Ceph username, etc.) to Onedata user accounts.

In order to support LUMA, storage provider has deploy default LUMA service or implement a simple REST service compliant with [LUMA API](), which handles custom user mapping.

Current implementation supports the following storage backends:
- POSIX
- Ceph
- Amazon S3
- OpenStack SWIFT


New storage types are added by means of plugin system of generators. A generator is responsible for:
- mapping Onedata users to storage specific users,
- creating user credentials for accessing the actual storage.

LUMA is written using [Flask](http://flask.pocoo.org/) framework and uses 
[sqlite](https://www.sqlite.org/) backend to store information about user 
credentials.

## LUMA in Onedata
Used in [Onedata](onedata.org), LUMA allows to map Onedata user credentials 
to storage/system user credentials. By default, it is deployed as part of 
[Oneprovider](https://github.com/onedata/op-worker), however it can 
be replaced by an external LUMA server. Admins can use an external LUMA 
server to define dedicated policies for credentials management.

## LUMA Docker Image
Every release of LUMA is published as a docker image. Here are few example 
commands how to use it:

```shell
docker run -it onedata/luma:VFS-2019

curl --get -d global_id=1 -d storage_type=DirectIO -d space_name=posix -d source_hostname=hostname -d source_ips=[] -d user_details={}  <docker_ip>:5000/get_user_credentials
curl --get -d global_id=0 -d storage_type=Ceph -d space_name=ceph -d source_hostname=hostname -d source_ips=[] -d user_details={}  <docker_ip>:5000/get_user_credentials
curl --get -d global_id=1 -d storage_type=AmazonS3 -d space_name=s3 -d source_hostname=hostname -d source_ips=[] -d user_details={}  <docker_ip>:5000/get_user_credentials
```

## LUMA sources
LUMA sources can be downloaded directly from our [GitHub repository](https://github.com/onedata/luma).

## LUMA Usage Guide

### Pairing generator with storage type or id.

LUMA requires that generator implementation must be paired with storage ID or 
type. This is achieved by providing an entry in generators_mapping. Using these pairings, LUMA will try to choose proper generator for given request. In request user may provide `storage_id`, `storage_type` or both. When only `storage_id` is provided LUMA will try to find its `storage_type` using `storage_id` to `storage_type` mapping. Then LUMA will try to use `storage_id` (if provided) to find generator, if this fails LUMA will use `storage_type` to find appropriate generator. If no generator is found LUMA will respond with error. To summarize:

1. User provides generators_mapping (storage id/type to `generator_id`) and 
optionally `storage_id` to `storage_type` mapping,
2. LUMA receives request for mapping with `storage_id`, `storage_type` or both,
3. If only `storage_id` is provided LUMA tries to find its storage_type,
4. LUMA tries to find suitable generator using `storage_id`,
5. If previous operation fails LUMA uses `storage_type` to find generator,
6. If both previous operations fail LUMA returns an error, if one of the operations succeeds generator is executed and the mapping is returned.

### Initializing database

To initialize LUMA server database run command:

```shell
$ ./init_db.py
```

Optional arguments:

| Param                      | Description                                           |
|:---------------------------|:------------------------------------------------------|
| -h, --help                 | Print help message and exit                                 |
| -c CONFIG, --config CONFIG | Path to configuration file (default: config.cfg) |


### Start LUMA server

To start LUMA server run command:

```shell
$ ./main.py
```

Optional arguments:

| Param                                                                        | Description                                                             |
|:-----------------------------------------------------------------------------|:------------------------------------------------------------------------|
| -h, --help                                                                   | Print help message and exit                                                   |
| -cm CREDENTIALS_MAPPING_FILE, --credentials-mapping CREDENTIALS_MAPPING_FILE | JSON file with array of credentials mappings (default:None)             |
| -gm GENERATORS_MAPPING, --generators-mapping GENERATORS_MAPPING              | JSON file with array of storages to generators mappings (default: None) |
| -sm STORAGES_MAPPING, --storages-mapping STORAGES_MAPPING                    | JSON file with array of storage id to type mappings (default: None)     |
| -c CONFIG, --config CONFIG                                                   | Configuration file (default: config.cfg)                   |


## Extending LUMA

LUMA provides support for custom storage systems by means of generators.

### Adding new generators
To support new storage or existing one in different way, user should create a Python script in `generators` folder. All files in this folder are imported automatically by LUMA.

#### Sample Generator

Here is a sample generator for POSIX storage.

```python
import hashlib
import ConfigParser
import os

config = ConfigParser.RawConfigParser()
config.read(
    os.path.join(os.path.dirname(os.path.realpath(__file__)), 'generators.cfg'))

#
# Define a range for generated user ID's
#
LowestUID = config.getint('posix', 'lowest_uid')
HighestUID = config.getint('posix', 'highest_uid')

def gen_storage_id(id):
    """ Generate a user/group ID based on MD5 hash of original ID and scale it to defined ID range."""
    m = hashlib.md5()
    m.update(id)
    return LowestUID + int(m.hexdigest(), 16) % HighestUID


def create_user_credentials(global_id, storage_type, storage_id, space_name,
                            source_ips, source_hostname, user_details):
    """Create user credentials for POSIX storage based on provided user data.
    Sample output:
    {
        "uid": 31415,
        "gid": 31415
    }
    """
    if global_id == "0":
        return {'uid': 0, 'gid': 0}

    return {'uid': gen_storage_id(global_id), 'gid': gen_storage_id(global_id)}
```


It has to implement function

```python
def create_user_credentials(global_id, storage_type, storage_id, space_name, 
                            source_ips, source_hostname, user_details)
```

and return user's credentials as a DICT. This DICT must contain:

| Storage type    | Params                   | Note                              |
|:----------------|:-------------------------|:----------------------------------|
| Posix           | uid, gid (optional)      | If gid is omitted oneprovider will try to generate gid based on space name. If this fails gid will be equal to uid. |
| Ceph            | user_name, user_key      |                                   |
| Amazon S3       | access_key, secret_key   |                                   |

RuntimeErrors thrown in generators will be caucht by LUMA and it will 
be converted to a meaningfull error for the user.

In the file `generators.cfg` user can specify configuration of the generator. 
Example configuration for POSIX;

```
[posix]
lowest_uid = 1000
highest_uid = 65536
```

more examples can be found in `generators/generators.cfg.example`.


### Registering Generators

#### Pairing generator with storage_id
The generators need to be paired with specific storage by specifying a tuple of `storage_id` and `generator_id` (storage type may be provided instead of `storage_id`). Those mappings are located in **generators_mapping.json** and can be passed to LUMA via command line options. Example file is located in `/example_config` folder.

```json
[
  {
    "storage_id": "Ceph",
    "generator_id": "ceph"
  },
  {
    "storage_type": "DirectIO",
    "generator_id": "posix"
  },
  {
    "storage_type": "AmazonS3",
    "generator_id": "s3"
  }
]
```

#### Registering ID to type mapping
Additionally, one can specify a pairing of `storage_id` and `storage_type`. 
If LUMA fails to use a generator for a specific `storage_id` it will then 
try to find one matching `storage_type`.

```json
[
  {
    "storage_id" : "id",
    "storage_type": "type"
  },
  {
    "storage_id" : "id2",
    "storage_type": "type2"
  }
]

```

#### Mapping user to credentials
Sometimes it might be necessary to bypass the generators for specific users. LUMA allows to specify static `user(storage_type/id)->credentials` mappings:

```json
[
  {
    "global_id": "id",
    "storage_id": "storage_id",
    "posix": {
      "uid" : 1
    }
  },
  {
    "global_id": "id2",
    "storage_id": "storage_id2",
    "credentials": {
      "access_key": "ACCESS_KEY",
      "secret_key": "SECRET_KEY"
    }
  }
]
```

### Configuration file
LUMA configuration file allows you to specify:

```shell
DATABASE = 'luma_database.db' # db path
HOST = '0.0.0.0' # the hostname to listen on. Set this to '0.0.0.0' to have the server available externally
PORT = 5000 # the port of the webserver. Defaults to 5000
```

and any option handled by [Flask](http://flask.pocoo.org/docs/0.10/config/#builtin-configuration-values) web server.

## LUMA API

### Get User Credentials

Returns JSON with user credentials to storage. Use `GET` method.

#### URL

```shell
 /get_user_credentials
```

#### URL Params

| Param           | Description                                                  |
|:----------------|:-------------------------------------------------------------|
| global_id       | user global id                                               |
| storage_type    | storage type e.g. `Ceph`                                     |
| storage_id      | storage id                                                   |
| space_name      | space name                                                   |
| source_ips      | IPs list of provider performing query as string encoded JSON |
| source_hostname | hostname of provider performing query                        |
| user_details    | detail information of user as string encoded JSON            |

**NOTE:** One of `storage_id`, `storage_type` may be omitted in request.

User details:

* id
* name
* connected_accounts - list of open id acconts, each containing:
  * provider_id
    * user_id
    * login
    * name
    * email_list
* alias
* email_list

### Success Response:

* **Code:** 200 OK <br />
  **Content:**
  * POSIX
```json
{
  "status": "success",
  "credentials": {
      "uid": 31415,
      "gid": 31415
  }
}
```
  * CEPH
```json
{
  "status": "success",
  "credentials": {
      "access_key": "ACCESS_KEY",
      "secret_key": "SECRET_KEY"
  }
}
```
  * AMAZON S3
```json
{
  "status": "success",
  "credentials": {
      "user_name": "USER",
      "user_key": "KEY"
  }
}
```

### Error Response:

* **Code:** 422 Unprocessable Entity <br />
  **Content:** 
  
```json
{ 
    "status": "error", 
    "message": "Missing parameter global_id" 
}
```

  OR

* **Code:** 500 Internal Server Error <br />
  **Content:** 
  
```json
{ 
    "status": "error", 
    "message": "MESSAGE" 
}
```

