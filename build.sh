#!/bin/bash
docker run --rm -v `pwd`:/docs docker.onedata.org/gitbook-compiler:1.1.0 install
docker run --rm -v `pwd`:/docs docker.onedata.org/gitbook-compiler:1.1.0 build
