

# LUMA - Local User MApping

Luma maps Onedata users to storage specific users, in the process of authorizing them with the storage resources.
> odpowiada za mapowanie użytkowników onedata do credentiali na danym storage (posix, ceph, s3 - w readme jest konieczne minimum danych dla każdego).

Current implementation supports:

- POSIX
- Ceph
- Amazon S3

## Luma Usage Guide


### Initialize Database

To init LUMA server database run command:

~~~bash
$ ./init_db.py
~~~

Optional arguments:

| Param                      | Description                              |
| :------------------------- | :--------------------------------------- |
| -h, --help                 | help message and exit                    |
| -c CONFIG, --config CONFIG | cfg file with app configuration (default: config.cfg) |


### Start LUMA server

To start LUMA server run command:

~~~bash
$ ./main.py
~~~

Optional arguments:

| Param                                    | Description                              |
| ---------------------------------------- | :--------------------------------------- |
| -h, --help                               | help message and exit                    |
| -cm CREDENTIALS_MAPPING_FILE, --credentials-mapping CREDENTIALS_MAPPING_FILE | json file with array of credentials mappings (default:None) |
| -gm GENERATORS_MAPPING, --generators-mapping GENERATORS_MAPPING | json file with array of storages to generators mappings (default: None) |
| -sm STORAGES_MAPPING, --storages-mapping STORAGES_MAPPING | json file with array of storage id to type mappings (default: None) |
| -c CONFIG, --config CONFIG               | cfg file with app configuration (default: config.cfg) |


## Extending LUMA

Luma implements support for storages by means of generators. 

### Adding new generators
To support new storage, user should create a python script in `generators` folder. All files in this folder are scanned by LUMA.


#### Sample Generator

Here is a sample generator for POSIX storage.


~~~python
import hashlib
import ConfigParser
import os

config = ConfigParser.RawConfigParser()
config.read(
    os.path.join(os.path.dirname(os.path.realpath(__file__)), 'generators.cfg'))

LowestUID = config.getint('posix', 'lowest_uid')
HighestUID = config.getint('posix', 'highest_uid')


def gen_storage_id(id):
    m = hashlib.md5()
    m.update(id)
    return LowestUID + int(m.hexdigest(), 16) % HighestUID


def create_user_credentials(global_id, storage_type, storage_id, source_ips,
                            source_hostname, user_details):
    """Creates user credentials for POSIX storage based on provided user data.
    Sample output:
    {
        "uid": 31415
    }
    """
    if global_id == "0":
        return {'uid': 0}

    return {'uid': gen_storage_id(global_id)}
~~~


It has to implement functon

~~~python
def create_user_credentials(global_id, storage_type, storage_id, source_ips, source_hostname, user_details)
~~~

and return a users credentials as a DICT. For a detailed explanation of arguments, refer to REST API bellow.

> (przykłady w README - pole crednetials w JSONach). 

RuntimeErrors thrown in generators will be caucht by LUMA and it will be converted to a meaningfull error for the user.

> W razie błędu można rzucić RuntimeError które zostanie przez lumę przetworzone do jsona z komunikatem o błędzie. Opis parametrów też w README


In the file `generators.cfg` user can specify configuration of the generator. Example configuration for POSIX;

~~~
[posix]
lowest_uid = 1000
highest_uid = 65536
~~~

more examples can be found in `generators/generators.cfg.example`.


### Registering Generators

The generators needs to be paired with specyfic storage by specifying a tuple of `storage_id` and `generator_id`.  Those mapings are located in **generators_mapping.json** Służy do tego generators_mapping które możemy podać przy uruchomieniu lumy, przykład jest w example_config. 

~~~json
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
~~~

### Registering id to type mapping

Dodatkowo można podać mapowania storage_id - storage_type - LUMA jeśli nie zna generatora dla id będzie próbować dla typu. 

~~~json
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

~~~

### Registering user to credentials

Trzecią opcję jest podane domyślnych mapowań - czyli mamy na sztywno zapisane że dla danego użytkownika na danym storage id/type są takie credentiale. Przykład w tym samym miejscu.

~~~json
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
~~~
### Config
Plik z konfigurację zawiera takie pola jak host, ścieżka do bazy czy debug - to jest konfiguracja do Flaska.

~~~
DATABASE = 'luma_database.db'
HOST = '0.0.0.0'
~~~

### Supported Storages

Domyślne typy storage w Onedata na obecną chwilę to:

- Ceph
- DirectIO
- AmazonS3



## LUMA API


### Get User Credentials


Returns json with user credentials to storage. Use `GET` method.

#### URL

~~~
 /get_user_credentials
~~~

#### URL Params

| Param           | Description                              |
| :-------------- | :--------------------------------------- |
| global_id       | user global id                           |
| storage_type    | storage type e.g. `Ceph`                 |
| storage_id      | storage id                               |
| source_ips      | IPs list of provider performing query as string encoded JSON |
| source_hostname | hostname of provider performing query    |
| user_details    | detail information of user as string encoded JSON |

**NOTE:** One of `storage_id`, `storage_type` may be omitted in request.

User details:

* id
* name
* connected_accounts
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
          "uid": 31415
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
  **Content:** `{ "status: "error", "message": "Missing parameter global_id" }`

  OR

* **Code:** 500 Internal Server Error <br />
  **Content:** `{ "status: "error", "message": "MESSAGE" }`

