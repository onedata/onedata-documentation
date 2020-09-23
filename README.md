# Onedata documentation

This documentation is build using [vuepress](vuepress.vuejs.org). The source files reside in `./docs/`.

## Building and previewing
In order to build documentation execute `make build`. You can locally preview it by executing `make dev`. While previewing you can modify source files. The documentation will be reloaded when changed. However, sometimes reruning the build or the preview migth be needed. Ctrl-C interrupts the preview. 

### Make targets

- all - default target. It builds the docs.
- submodules - checkouts the repo submodules (bamboos).
- build - builds the docs using a docker image. Results are placed in docs/.vuepress/dist
- dev - builds and allows live previewing the docs under localhost:8080. 
- package - creates a tar.gz package with containing the docs.
- build-native - builds the docs using yarn. Node, yarn, vuepress and deps should already be installed.
- dev-native - live preview using yarn.
- install-native - installs vuepress locally.
- clean - remove all non-source files and dirs.

## Adding .md files
- prepare the new .md file and place it in the relevant directory, e.g., `./docs/admin-guide/onezone/`,
- add appropriate entry in `./docs/.vuepress/config.js` in the `sidebar` object.

## Routing
Custom routes can be placed in `./docs/.vuepress/enhanceApp.js`.
