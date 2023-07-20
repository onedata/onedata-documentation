.PHONY: all build dev clean

# FIXME: VFS-11182 Use final v3 compiler
VUEPRESS_IMG=docker.onedata.org/vuepress-compiler:v3-alpha.2

all: build

lint:
	docker run --rm -v `pwd`:/vuepress ${VUEPRESS_IMG} lint

format-all:
	docker run --rm -v `pwd`:/vuepress ${VUEPRESS_IMG} format-all

build:
	docker run --rm -v `pwd`:/vuepress ${VUEPRESS_IMG} build
	./inject-release.sh

package:
	cd docs/.vuepress/dist && tar zcf ../../../onedata_documentation.tar.gz .

dev:
	docker run --rm -p 8080:8080 -it -v `pwd`:/vuepress -v `pwd`/yarn-cache:/usr/local/share/.cache:delegated ${VUEPRESS_IMG} dev

submodules:
	git submodule sync --recursive ${submodule}
	git submodule update --init --recursive ${submodule}

preview: build
	@bash -c "sleep 1; echo 'opening http://localhost:8080/intro.html ...'; xdg-open http://localhost:8080/intro.html" &
	@cd docs/.vuepress/dist && python -m `python -c 'import sys; print("http.server" if sys.version_info[:2] > (2,7) else "SimpleHTTPServer")'` 8080

clean:
	@rm -rf node_modules yarn-cache docs/.vuepress/dist

codetag-tracker:
	./bamboos/scripts/codetag-tracker.sh --branch=${BRANCH} --excluded-dirs=node_modules,docs/.vuepress/dist
