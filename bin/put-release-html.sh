#!/bin/sh
RELEASE=21.02.0-alpha28
find _book -name '*.html' -exec sed -i "s/__ONEDATA_RELEASE__/${RELEASE}/g" {} \;
