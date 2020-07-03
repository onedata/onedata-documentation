#!/bin/sh
RELEASE=20.02.0-beta4
find _book -name '*.html' -exec sed -i "s/__ONEDATA_RELEASE__/${RELEASE}/g" {} \;
