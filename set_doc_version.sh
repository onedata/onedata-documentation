#!/bin/bash

sed -i "s/ONEDATA_DOC_VERSION = .*;/ONEDATA_DOC_VERSION = \"$1\";/g" node_modules/gitbook-plugin-onedata-theme/book/onedata.js
