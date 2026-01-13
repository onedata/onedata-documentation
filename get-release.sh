#!/bin/bash

# Authors: Jakub Liput
# Copyright (C) 2025 Onedata (onedata.org)
# This software is released under the MIT license cited in 'LICENSE.txt'

# Usage: ./get-release.sh [--major]
# Prints the release version from RELEASE file.
# If --major flag is used, only the major component is printed, e.g. "21.02", "25".

cd "$(dirname "$0")"
. ./utils.sh

if [ "$1" == "--major" ]; then
  echo $(get_major_release)
else
  echo $(get_release)
fi