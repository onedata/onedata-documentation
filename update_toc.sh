#!/bin/bash
cat SUMMARY.md.template > SUMMARY.md
sed -i -e  '/SWAGGER_INCLUDE ONEZONE_PATHS/ {' -e 'r doc/advanced/rest/onezone/PATHS_TOC.md' -e 'd' -e '}' SUMMARY.md
sed -i -e  '/SWAGGER_INCLUDE ONEZONE_DEFINITIONS/ {' -e 'r doc/advanced/rest/onezone/DEFINITIONS_TOC.md' -e 'd' -e '}' SUMMARY.md
sed -i -e  '/SWAGGER_INCLUDE ONEPROVIDER_PATHS/ {' -e 'r doc/advanced/rest/oneprovider/PATHS_TOC.md' -e 'd' -e '}' SUMMARY.md
sed -i -e  '/SWAGGER_INCLUDE ONEPROVIDER_DEFINITIONS/ {' -e 'r doc/advanced/rest/oneprovider/DEFINITIONS_TOC.md' -e 'd' -e '}' SUMMARY.md
sed -i -e  '/SWAGGER_INCLUDE ONEPANEL_PATHS/ {' -e 'r doc/advanced/rest/onepanel/PATHS_TOC.md' -e 'd' -e '}' SUMMARY.md
sed -i -e  '/SWAGGER_INCLUDE ONEPANEL_DEFINITIONS/ {' -e 'r doc/advanced/rest/onepanel/DEFINITIONS_TOC.md' -e 'd' -e '}' SUMMARY.md


