#!/bin/sh
if [ $# -eq 0 ] ; then
  file="_book/gitbook/plugins/gitbook-plugin-onedata-theme/onedata.js"
else 
  file="$1"
fi

if [[ "$ONEDATA_DOC_VERSION" != "" ]]; then
  echo "$ONEDATA_DOC_VERSION" | sed -e '/^\s*$/d' -e 's/^[[:space:]]*/"/g' -e 's/$/\\n"+/' | sed -e '$ s/.$//' | tr -d '\n' > /tmp/eee1
  file=$1
  sed -i -r -e '/window.ONEDATA_DOC_VERSION = null;/ {'  -e 's/(.* =).*/\1 /'  -e 'r /tmp/eee1'  -e 'a ;' -e '}' $file
  head $file
fi
