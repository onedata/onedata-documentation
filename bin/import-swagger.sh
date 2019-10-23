#!/bin/bash

## This script copies swagger.json files, assumed to be present in directories
## {onepanel,onezone,oneprovider,luma}-swagger in the same path as onedata-documentation

RELEASE=$1
TARGET="doc/swagger/$RELEASE"

if [ -z "$RELEASE" ]; then
    echo "Provide release name as the first argument"
    exit 1
fi

for product in {luma,onepanel,oneprovider,onezone}; do
    FILE="../$product-swagger/swagger.json"
    if [ -f "$FILE" ]; then
        mkdir -p "$TARGET/$product"
        cp -v "$FILE" $TARGET/$product/
    else
        echo "File $FILE missing"
   fi
done

