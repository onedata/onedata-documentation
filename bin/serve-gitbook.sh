#!/bin/bash

PORT=8888

DIR=$( cd ${0%/*} && pwd -P )
cd ${DIR}/../_book
bash -c "sleep 1; open http://localhost:${PORT}" &
python -m $(python -c 'import sys; print("http.server" if sys.version_info[:2] > (2,7) else "SimpleHTTPServer")') ${PORT}

