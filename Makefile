.PHONY: all build dev clean

VUEPRESS_IMG=docker.onedata.org/vuepress-compiler:v5
LANGUAGETOOL_IMG=docker.onedata.org/languagetool:v1

all: build

lint:
	docker run --rm -v `pwd`:/vuepress ${VUEPRESS_IMG} lint

check-language:
	docker run --rm -t -e "TERM=xterm-256color" -v`pwd`:/vuepress ${LANGUAGETOOL_IMG} --client-configuration=/vuepress/.vscode/settings.json /vuepress/docs

format-all:
	docker run --rm -v `pwd`:/vuepress ${VUEPRESS_IMG} format-all

build:
	docker run --rm -v `pwd`:/vuepress ${VUEPRESS_IMG} build
	./inject-release.sh

package:
	cd rel/ && tar zcf ../onedata_documentation.tar.gz .

dev:
	docker run --rm -p 8080:8080 -it -v `pwd`:/vuepress -v `pwd`/yarn-cache:/usr/local/share/.cache:delegated ${VUEPRESS_IMG} dev

submodules:
	git submodule sync --recursive ${submodule}
	git submodule update --init --recursive ${submodule}

preview: build
	@bash -c "sleep 1; echo 'opening http://localhost:8080/future-documentation/intro.html ...'; xdg-open http://localhost:8080/future-documentation/intro.html" &
	@cd rel/ && python -m `python -c 'import sys; print("http.server" if sys.version_info[:2] > (2,7) else "SimpleHTTPServer")'` 8080

clean:
	@rm -rf node_modules yarn-cache rel/

codetag-tracker:
	./bamboos/scripts/codetag-tracker.sh --branch=${BRANCH} --excluded-dirs=node_modules,rel
