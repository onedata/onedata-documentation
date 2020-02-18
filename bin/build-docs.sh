#!/bin/bash

GITBOOK_IMG='docker.onedata.org/gitbook-compiler:ID-a2746a377f'
REDOC_IMG='onedata/redoc-cli:v1'

test -t 1 && TTY="-t"

case "${1}" in
    install-gitbook)
        docker run --rm -i ${TTY} -v `pwd`:/docs:delegated -v `pwd`/gitbook_cache:/root/.npm:delegated ${GITBOOK_IMG} install || exit $?
        ;;

    build-gitbook)
        docker run --rm -i ${TTY} -v `pwd`:/docs:delegated -v `pwd`/gitbook_cache:/root/.npm:delegated ${GITBOOK_IMG} build || exit $?
        ;;

    build-redoc)
        docker run --rm -i ${TTY} -v `pwd`:/docs:delegated ${REDOC_IMG} sh -c "cd /docs/_book/doc/swagger; /docs/bin/redoc_build_recursive.sh" || exit $?
        ;;

    *)
        echo "usage: build-docs.sh install-gitbook | build-gitbook | build-redoc"
        ;;
esac
