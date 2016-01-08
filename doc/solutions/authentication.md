# Authentication

Onedata does not
## Authentication

Onedata.org
- OAth2 (google, git etc.)
- OpenId (plgrid)
- authorization using session

RestAPI:
- certificate added for every request

CDMI:
- ?

Oneclient
- mount without direct io (authorization)
  - get access token from gui
  - use access token with onelcnet
  - get access code and write it in .local
  - when doing `ls` on local pc in mounted directory uids are the same as a local user. guis are ugly numbers
- mount with direct io
  - when doing `ls` on local pc in mounted directory uids are the same as a local user. guis also coresponds to proper system groups.
- mount with direct io on a laptop
  - put certificate on the provder (in 2.0 provider keeps them)
  - when doing `ls` on local pc in mounted directory uids are the same as a local user. guis are ugly numbers

When oneclient gets files metadata from GR (files that are lcoated on particualr provider) it also receives those hashed uid/gids



In Global Registry:
- User uid is created when user is created in Onedata.
- Space gid is created when space created.

In Provider:
- open first access of the space supported by the proivder, provider generates a  uid and gid for user na his space. It uses a hash function that can be configure to generate uid and gids from custom range.
   - for small installation it is ok
   - for large (plgrid) admins may want to create uids and girds for future users/spaces and have hash function mach them
