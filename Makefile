.PHONY: all build dev clean

VUEPRESS_IMG=docker.onedata.org/vuepress-compiler:v1

all: build

build:
	docker run --rm -v `pwd`:/vuepress -v `pwd`/yarn-cache:/usr/local/share/.cache:delegated ${VUEPRESS_IMG} build
	./inject-release.sh

package:
	cd docs/.vuepress/dist && tar zcf ../../../onedata-documentation.tar.gz .

dev:
	docker run --rm -p 8080:8080 -it -v `pwd`:/vuepress -v `pwd`/yarn-cache:/usr/local/share/.cache:delegated ${VUEPRESS_IMG} dev

submodules:
	git submodule sync --recursive ${submodule}
	git submodule update --init --recursive ${submodule}

install-native:
	yarn install --no-lockfile

build-native:
	yarn docs:build
	./inject-release.sh

dev-native:
	yarn docs:dev

preview:
	@bash -c "sleep 1; echo 'open http://localhost:8080/intro.html'; open http://localhost:8080/intro.html" &
	@cd docs/.vuepress/dist && python -m `python -c 'import sys; print("http.server" if sys.version_info[:2] > (2,7) else "SimpleHTTPServer")'` 8080

clean:
	@rm -rf node_modules package-lock.json yarn-cache docs/.vuepress/dist yarn.lock

codetag-tracker:
	./bamboos/scripts/codetag-tracker.sh --branch=${BRANCH} --excluded-dirs=node_modules,docs/.vuepress/dist
