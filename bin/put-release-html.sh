#!/bin/sh
RELEASE=19.02.2
find _book -name '*.html' -exec sed -i "s/__ONEDATA_RELEASE__/${RELEASE}/g" {} \;
