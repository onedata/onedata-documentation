#!/bin/bash

# Authors: Jakub Liput
# Copyright (C) 2025 ACK CYFRONET AGH
# This software is released under the MIT license cited in 'LICENSE.txt'

# Usage: ./node-launcher.js <command> 
# 
# This script checks required version of Node.js, adds required flags and launches
# <command> in npm context.

NODE_VERSION_STRING=$(node --version)
NODE_VERSION_MAJOR=$(echo $NODE_VERSION_STRING | sed -E 's/v([0-9]+).*/\1/')
NODE_VERSION_MINOR=$(echo $NODE_VERSION_STRING | sed -E 's/v[0-9]+\.([0-9]+).*/\1/')

if [ $NODE_VERSION_MAJOR -lt 15 -a $NODE_VERSION_MINOR -lt 15 ]; then
  echo "This script requires Node.js >= 14.14"
  exit 1
fi

if [ $NODE_VERSION_MAJOR -gt 17 ]; then
  export NODE_OPTIONS=--openssl-legacy-provider
fi

ls -d node_modules > /dev/null
if [ $? -ne 0 ]; then
  echo "The node_modules directory is missing - did you installed dependencies using 'npm run deps'?"
  exit 2
fi

npx --no-install $@