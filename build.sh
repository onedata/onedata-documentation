#!/bin/bash
docker run --rm -v `pwd`:/docs docker.onedata.org/gitbook-compiler:ID-a2746a377f install
docker run --rm -v `pwd`:/docs docker.onedata.org/gitbook-compiler:ID-a2746a377f build
