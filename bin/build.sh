#!/bin/bash

docker run --rm -v `pwd`:/docs docker.onedata.org/gitbook-compiler:ID-a2746a377f install
docker run --rm -v `pwd`:/docs docker.onedata.org/gitbook-compiler:ID-a2746a377f build
docker run --rm -v `pwd`:/docs onedata/redoc-cli:v1 sh -c "cd /docs/_book/doc/swagger; /docs/bin/redoc_build_recursive.sh"
