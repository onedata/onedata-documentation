#!/bin/bash
cd gitbook
docker run --rm -v `pwd`:/docs -i  docker.onedata.org/gitbook-compiler:1.0.0 install
docker run --rm -v `pwd`:/docs -i  docker.onedata.org/gitbook-compiler:1.0.0 build
mv _book ../build_dir
