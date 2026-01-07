#!/bin/bash
# This script reads the current release version from the ${RELEASE_FILE} and
# injects it into the static docs artifact - by replacing the occurrences of
# ${RELEASE_PLACEHOLDER} with the actual release number.

cd "$(dirname "$0")"
. ./utils.sh
MAJOR_RELEASE=$(get_major_release)
RELEASE=$(get_release)
RELEASE_PLACEHOLDER="xRELEASExVERSIONx"
DIST_DIRECTORY="./rel/documentation/${MAJOR_RELEASE}"

cd "$(dirname "$0")"

if [[ "$OSTYPE" == "darwin"* ]]; then
    find ${DIST_DIRECTORY} \( -name '*.html' -or -name '*.js' \) -exec sed -i '' "s/${RELEASE_PLACEHOLDER}/${RELEASE}/g" {} +
else
    find ${DIST_DIRECTORY} \( -name '*.html' -or -name '*.js' \) -exec echo {} +
    find ${DIST_DIRECTORY} \( -name '*.html' -or -name '*.js' \) -exec sed -i "s/${RELEASE_PLACEHOLDER}/${RELEASE}/g" {} +
fi
