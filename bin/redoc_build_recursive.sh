#!/bin/bash

for dir in `find . -name 'swagger.json' -exec dirname {} \;`; do
  redoc-cli bundle --cdn -o $dir/redoc-static.html $dir/swagger.json &&
  sed -i 's,https://unpkg.com/redoc@next/bundles/redoc.standalone.js,/assets/redoc.standalone.js,g' $dir/redoc-static.html
done
