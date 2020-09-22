# Onedata documentation

This documentation is build using [vuepress](vuepress.vuejs.org). The source files reside in `./docs/`.

## Building and previewing
In order to build documentation execute `make build`. You can locally preview it by executing `make dev`. While previewing you can modify source files. The documentation will be reloaded when changed. However, sometimes reruning the build or the preview migth be needed. Ctrl-C interrupts the preview. 


## Adding .md files
- prepare the new .md file and place it in the relevant directory, e.g., `./docs/admin-guide/onezone/`,
- add appropriate entry in `./docs/.vuepress/config.js` in the `sidebar` object.

## Routing
Custom routes can be placed in `./docs/.vuepress/enhanceApp.js`.