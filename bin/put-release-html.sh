#!/bin/sh
RELEASE=20.02.1
find docs -name '*.html' -exec sed -i "s/__ONEDATA_RELEASE__/${RELEASE}/g" {} \;
