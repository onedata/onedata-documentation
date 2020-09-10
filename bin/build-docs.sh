#!/bin/bash

GITBOOK_IMG='docker.onedata.org/gitbook-compiler:ID-a2746a377f'
REDOC_IMG='onedata/redoc-cli:v2'
VUEPRESS_IMG='node:14.9'

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
    install-vuepress)
        docker run --rm -i ${TTY} -v `pwd`/vuepress:/vuepress:delegated -v `pwd`/yarn-cache:/usr/local/share/.cache:delegated ${VUEPRESS_IMG} bash -c "cd /vuepress; yarn add -D vuepress" || exit $?
        ;;
    build-vuepress)
        docker run --rm -i ${TTY} -v `pwd`/vuepress:/vuepress:delegated -v `pwd`/yarn-cache:/usr/local/share/.cache:delegated ${VUEPRESS_IMG} bash -c "cd /vuepress; yarn docs:build" || exit $?
        ;;
    
    *)
        echo "usage: build-docs.sh install-vuepress | install-vuepress | install-gitbook | build-gitbook | build-redoc"
        ;;
esac
