#!/bin/bash

cd "$(dirname "$0")"
. ./utils.sh
MAJOR_RELEASE=$(get_major_release)

./node-launcher.sh vuepress build docs --dest rel/documentation/${MAJOR_RELEASE}
