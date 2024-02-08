#!/bin/bash
# This script reads the current release version from the ${RELEASE_FILE} and
# injects it into the static docs artifact - by replacing the occurrences of
# ${RELEASE_PLACEHOLDER} with the actual release number.

RELEASE_FILE="./RELEASE"
RELEASE_PLACEHOLDER="\${RELEASE}"
DIST_DIRECTORY="./rel/future-documentation"

cd "$(dirname "$0")"

RELEASE=`cat ${RELEASE_FILE} | xargs` # xargs trims whitespaces

if [[ "$OSTYPE" == "darwin"* ]]; then
    find ${DIST_DIRECTORY} -name '*.html' -or -name '*.js' -exec sed -i '' "s/${RELEASE_PLACEHOLDER}/${RELEASE}/g" {} +
else
    find ${DIST_DIRECTORY} -name '*.html' -or -name '*.js' -exec sed -i "s/${RELEASE_PLACEHOLDER}/${RELEASE}/g" {} +
fi
