#!/bin/bash
#
# Generate SUMMARY.md from indexes generated from swagger-gitbook for specific services
#
./update_toc.sh

#
# Build the documentation
#
docker run --rm -v `pwd`:/docs docker.onedata.org/gitbook-compiler:1.1.0 install
docker run --rm -v `pwd`:/docs docker.onedata.org/gitbook-compiler:1.1.0 build
