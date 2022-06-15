#!/bin/sh
RELEASE=20.02.17
find _book -name '*.html' -exec sed -i "s/__ONEDATA_RELEASE__/${RELEASE}/g" {} \;
