# REST API
REST API is based on open standards, you can use any web development language or command line tool capable of generating an HTTP request to access the API.

## Authentication
In brief authentication proceed through following steps:

* Client opens HTTPS connection and sends his certificate and all other certificates required to associate his certificate with certificate authorities present on cluster.
* Each HTTPS connection is accepted regardless of sent certificates. However all certificates are saved in connection session.
* If connection requires authentication, and in case of REST requests it does, immediately after connection is established sent certificates are validated using Grid Security Infrastructure.
* If sent certificate fails verification or is not not present in database, connection is closed.
* If sent certificate passes verification its distinguished name is associated with single entry in users database and since than client can access cluster resources.

## Structure of the REST URIs

Onedata's REST APIs provide access to resources (data entities) via URI paths. To use a REST API, your application will make an HTTP request and parse the response. The Onedata REST API uses JSON as its communication format, and the standard HTTP methods like GET, PUT, POST and DELETE. URIs for Onedata REST API resource have the following structure:

~~~
http://host:port/rest/api-version/path/to/resource
~~~

Where *api-version* can be of following:

* number - which stands for an exact API version
* latest - which stands for most recent, stable version

We strongly recommend usage of the latter option especially due to introduction of new features and elimination of bugs in system.

Example URI that would retrieve content of dir directory.

~~~
https://example.com/rest/latest/files/dir
~~~

For more information see a full list of available resources.

## How to create proxy certificate?

To create proxy certificate run grid-proxy-init script with argument -out path_to_proxy_cert. This script can be found at root directory on cluster and requires presence of main PLGrid certificate in /root/.globus directory.

Example:

sh grid-proxy-init -out proxy_cert
How to use proxy certificate?

Proxy certificate can be used with any computer software that provides data transfer using HTTPS protocol and supports HTTPS certificates. In following example content of dir directory will be retrieved using HTTP GET request and curl tool.

Example:

curl -i -k --cert proxy_cert -X GET https://example.com/rest/latest/files/dir

## Resources
REST-ish endpoint for interacting with Onedata.


#### /rest/latest/files

Methods

~~~
GET /rest/latest/files
Retrieve content of root directory and return as a list of names of files and subdirectories.

Response Headers:

Content-Type – application/json
Status Codes:
200 – OK
500 – Internal Server Error
Example request:

GET /rest/latest/files HTTP/1.1
Header: "content-type: application/json"
Host: example.com
Example responses:

HTTP/1.1 200 OK
connection: close
server: Cowboy
date: Sun, 05 Jan 2014 16:34:54 GMT
content-length: 12
Access-Control-Allow-Origin: *
content-type: application/json

["dir1","dir2","groups","file.txt"]
~~~

#### /rest/latest/files/(path)
Methods
~~~
GET /rest/latest/files/(path)
Retrieve content of specified file or directory. For path to an existing file this request returns its content. For path to an existing directory this request returns list of names of contained files and subdirectories.

Parameters:
path (string) – path to file or directory
Response Headers:

Content-Type – application/json for path to directory
Content-Type – MIME type for path to file
Status Codes:
200 – OK
404 – Not Found
500 – Internal Server Error
Example request:

GET /rest/latest/files/dir1/dir2 HTTP/1.1
Header: "content-type: application/json"
Host: example.com
Example responses:

HTTP/1.1 200 OK
connection: close
server: Cowboy
date: Sun, 05 Jan 2014 16:34:54 GMT
content-length: 12
Access-Control-Allow-Origin: *
content-type: application/json

["file.txt"]
POST /rest/latest/files/(path)
Upload data to specified path using multipart method. Path has to be a valid file system path, that is it can’t contain regular file as a subdirectory. Specified path can’t exist and will be created automatically.

Parameters:
path (string) – path where file will be uploaded
Request Headers:

Content-Type – multipart/form-data
Response Headers:

Content-Type – application/octet-stream
Status Codes:
100 – Continue
204 – No Content
422 – Unprocessable Entity
An example curl request to upload file ‘file.txt’, that is located in current directory, to remote location /dir/file.txt would be:

curl -i -k --cert proxy_cert -X POST -H "content-type: multipart/form-data" -F "file=@file.txt" https://example.com/rest/latest/files/dir/file.txt
Example request:

POST /rest/latest/files/dir/file.txt HTTP/1.1
Host: example.com
Header: "content-type: multipart/form-data"
Data: "file=@file.txt"
Example responses:

HTTP/1.1 100 Continue

HTTP/1.1 204 No Content
connection: close
server: Cowboy
date: Fri, 24 Jan 2014 08:43:05 GMT
content-length: 0
Access-Control-Allow-Origin: *
content-type: application/octet-stream
PUT /rest/latest/files/(path)
Upload data to specified path using multipart method. Path has to be a valid file system path, that is it can’t contain regular file as a subdirectory. If specified path doesn’t exist it will be created automatically. If specified path exists it will be overwritten.

Parameters:
path (string) – path where file will be uploaded
Request Headers:

Content-Type – multipart/form-data
Response Headers:

Content-Type – application/octet-stream
Status Codes:
100 – Continue
204 – No Content
422 – Unprocessable Entity
An example curl request to upload file ‘file.txt’, that is located in current directory, to remote location /dir/file.txt would be:

curl -i -k --cert proxy_cert -X PUT -H "content-type: multipart/form-data" -F "file=@file.txt" https://example.com/rest/latest/files/dir/file.txt
Example request:

PUT /rest/latest/files/dir/file.txt HTTP/1.1
Host: example.com
Header: "content-type: multipart/form-data"
Data: "file=@file.txt"
Example responses:

HTTP/1.1 100 Continue

HTTP/1.1 204 No Content
connection: close
server: Cowboy
date: Fri, 24 Jan 2014 08:43:05 GMT
content-length: 0
Access-Control-Allow-Origin: *
content-type: application/octet-stream
DELETE /rest/latest/files/(path)
Delete regular file at specified path if it exists.

Parameters:
path (string) – path to file or directory
Response Headers:

Content-Type – application/json
Content-Type – application/octet-stream
Status Codes:
204 – No Content
404 – Not Found
Example request:

DELETE /rest/latest/files/dir/file.txt HTTP/1.1
Header: "content-type: application/json"
Host: example.com
Example responses:

HTTP/1.1 404 Not Found
connection: close
server: Cowboy
date: Fri, 24 Jan 2014 08:50:18 GMT
content-length: 0
Access-Control-Allow-Origin: *
content-type: application/json
~~~

#### /rest/latest/attrs/(path)
Methods
~~~
GET /rest/latest/attrs/(path)
Retrieve attributes of specified file or directory as a record of structure {property : value}.

Fields of returned record:

file protection mode
file owner user ID
file owner group ID
file last access time
file last modification time
file or inode last change time
file type
file owner user name
file owner group name
Parameters:
path (string) – path to file or directory
Response Headers:

Content-Type – application/json
Status Codes:
200 – OK
404 – Not Found
500 – Internal Server Error
Example request:

GET /rest/latest/attrs/dir1/dir2 HTTP/1.1
Header: "content-type: application/json"
Host: example.com
Example responses:

HTTP/1.1 200 OK
connection: close
server: Cowboy
date: Sun, 05 Jan 2014 17:17:39 GMT
content-length: 157
Access-Control-Allow-Origin: *
content-type: application/json

{"mode":8,"uid":20000,"gid":20000,"atime":1388937272,"mtime":1388937283,"ctime":1388937272,"type":"DIR","size":0,"uname":"user","gname":"group"}
~~~

#### /rest/latest/shares

Methods
~~~
GET /rest/latest/shares
Retrieve shared files as a list of globally unique identifiers.

Response Headers:

Content-Type – application/json
Status Codes:
200 – OK
404 – Not Found
500 – Internal Server Error
Example request:

GET /rest/latest/files/shares HTTP/1.1
Header: "content-type: application/json"
Host: example.com
Example responses:

HTTP/1.1 200 OK
connection: close
server: Cowboy
date: Sun, 05 Jan 2014 17:47:00 GMT
content-length: 36
Access-Control-Allow-Origin: *
content-type: application/json

["04ef3c62ea0cdba9cd2ac1a860835efe"]
POST /rest/latest/shares
Share existing file. This request adds specified file to a list of shared files.

Parameters:
path (string) – path to file to be shared
Request Headers:

Content-Type – application/json
Response Headers:

Content-Type – application/json
Location – redirect link to shared file
Status Codes:
303 – See Other
422 – Unprocessable Entity
500 – Internal Server Error
An example curl request to share file /dir/file.txt would be:

curl -i -k --cert proxy_cert -H "content-type: application/json" -X POST https://example.com/rest/latest/shares/ -d '"dir/file.txt"'
Example request:

POST /rest/latest/files/shares HTTP/1.1
Host: example.com
Header: "content-type: application/json"
Data: "dir/file.txt"
Example responses:

HTTP/1.1 303 See Other
connection: close
server: Cowboy
date: Sun, 05 Jan 2014 18:38:17 GMT
content-length: 0
Access-Control-Allow-Origin: *
content-type: application/json
location: https://example.com/share/04ef3d726a2554f240bb15bf4cfa2a13
~~~

### /rest/latest/shares/(guid)

Methods
~~~
GET /rest/latest/shares/(guid)
Retrieve shared file details as a record of structure {property : value}.

Fields of returned record:

shared file path
shared file download url
Parameters:
guid (string) – shared files globally unique identifier
Response Headers:

Content-Type – application/json
Status Codes:
200 – OK
404 – Not Found
500 – Internal Server Error
Example request:

GET /rest/latest/files/shares/04ef3c62ea0cdba9cd2ac1a860835efe HTTP/1.1
Header: "content-type: application/json"
Host: example.com
Example responses:

HTTP/1.1 200 OK
connection: close
server: Cowboy
date: Sun, 05 Jan 2014 17:52:16 GMT
content-length: 108
Access-Control-Allow-Origin: *
content-type: application/json

{"file_path":"dir/file.txt","download_path":"https://example.com/share/04ef3c62ea0cdba9cd2ac1a860835efe"}
DELETE /rest/latest/shares/(guid)
Stop sharing existing file. This request removes specified file from a list of shared files.

Parameters:
guid (string) – shared files globally unique identifier
Response Headers:

Content-Type – application/json
Status Codes:
204 – No Content
405 – Method Not Allowed
500 – Internal Server Error
Example request:

DELETE /rest/latest/files/shares/04ef3c62ea0cdba9cd2ac1a860835efe HTTP/1.1
Header: "content-type: application/json"
Host: example.com
Example responses:

HTTP/1.1 204 No Content
connection: close
server: Cowboy
date: Sun, 05 Jan 2014 17:58:05 GMT
content-length: 0
Access-Control-Allow-Origin: *
content-type: application/json
~~~

## Errors & Validation

If a request fails due to client error, the resource will return an HTTP response code in the 40x range. These can be broadly categorised into:

| HTTP Code | Description        |
|:----------|:-------------------|
| 400       | Bad Request        |
| 401       | Unauthorized       |
| 403       | Forbidden          |
| 404       | Not Found          |
| 405       | Method Not Allowed |
