#!/bin/bash

GITBOOK_COMPILER_IMAGE=docker.onedata.org/gitbook-compiler:ID-a2746a377f

test -t 1 && USE_TTY="-t"

docker run --rm -i $USE_TTY -v `pwd`:/docs -v gitbook_cache:/root/.npm $GITBOOK_COMPILER_IMAGE install
docker run --rm -i $USE_TTY -v `pwd`:/docs -v gitbook_cache:/root/.npm $GITBOOK_COMPILER_IMAGE build
docker run --rm -i $USE_TTY -v `pwd`:/docs onedata/redoc-cli:v1 sh -c "cd /docs/_book/doc/swagger; /docs/bin/redoc_build_recursive.sh"
