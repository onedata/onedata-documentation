#!/bin/bash
cd "$(dirname "$0")"
. ./utils.sh

MAJOR_RELEASE=$(get_major_release)
URL="http://localhost:8080/documentation/${MAJOR_RELEASE}/intro.html"

bash -c "sleep 1; echo 'opening ${URL} ...'; xdg-open ${URL}" &
cd rel/ && python -m `python -c 'import sys; print("http.server" if sys.version_info[:2] > (2,7) else "SimpleHTTPServer")'` 8080