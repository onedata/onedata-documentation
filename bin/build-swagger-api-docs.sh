#!/bin/bash

test -t 1 && USE_TTY="-t"

docker run --rm -i $USE_TTY -v `pwd`:/docs onedata/redoc-cli:v1 sh -c "cd /docs/_book/doc/swagger; /docs/bin/redoc_build_recursive.sh"
