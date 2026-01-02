.PHONY: all build dev clean render-templates

MAJOR_RELEASE=25
VUEPRESS_IMG=docker.onedata.org/vuepress-compiler:v7
SETUID=-u $(shell id -u):$(shell id -g)
DOCKER_RUN=docker run -e NPM_CONFIG_CACHE=/tmp/.npm --rm -v `pwd`:/vuepress ${SETUID}

all: build

lint:
	${DOCKER_RUN} ${VUEPRESS_IMG} lint

check-language:
	./check-language.py

format-all:
	${DOCKER_RUN} ${VUEPRESS_IMG} format-all

build:
	${DOCKER_RUN} ${VUEPRESS_IMG} build
	./inject-release.sh

package:
	cd rel/ && tar zcf ../onedata_documentation.tar.gz .

dev:
	${DOCKER_RUN} -p 8080:8080 -it ${VUEPRESS_IMG} dev

submodules:
	git submodule sync --recursive ${submodule}
	git submodule update --init --recursive ${submodule}

preview: build
	@bash -c "sleep 1; echo 'opening http://localhost:8080/documentation/${MAJOR_RELEASE}/intro.html ...'; xdg-open http://localhost:8080/documentation/${MAJOR_RELEASE}/intro.html" &
	@cd rel/ && python -m `python -c 'import sys; print("http.server" if sys.version_info[:2] > (2,7) else "SimpleHTTPServer")'` 8080

# Templates are generated during the build process, but not updated automatically when "make dev" is running.
# In that case, this target can be used to force regeneration of the templates.
render-templates:
	${DOCKER_RUN} -it --entrypoint /bin/bash -v `pwd`:/vuepress ${VUEPRESS_IMG} -c "cd /vuepress && node ./render-templates.js"

clean:
	rm -rf node_modules yarn-cache rel/

codetag-tracker:
	./bamboos/scripts/codetag-tracker.sh --branch=${BRANCH} --excluded-dirs=node_modules,rel
