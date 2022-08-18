# Onedata documentation
This documentation is build using [vuepress](https://vuepress.vuejs.org).


## Guidelines
All docs should be edited and formatted in compliance with the [guidelines](GUIDELINES.md). 


## Building and developing
* `make build` builds the documentation within a docker.
* `make dev` prepares a local preview with livereload within a docker, allowing 
  convenient development. The livereload might not cope with some structural 
  changes, in such case the command must be re-run. `Ctrl-C` interrupts the preview.
* `make build-native` runs the `build` natively on the host (requires 
  `node >= 10.0` and `yarn`), might require `make install-native` beforehand.
* `make dev-native` starts the `dev` session natively on the host.
* `make preview` starts a simple HTTP server in python that serves the docs
  statically, giving a preview of what's in the build artifact (note that the 
  `dev` and `dev-native` targets do not inject the `RELEASE` version, only the
  placeholders are visible).


## Versioning
The current Onedata version to which the docs correspond is placed in the 
`RELEASE` file and injected into the docs using the `./inject-release.sh` 
script during the build.


## Build artifact
After a successful build, the static HTML files are placed in `docs/.vuepress/dist`.
Calling `make package` will pack it up into a tarball.
