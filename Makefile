.PHONY: all build preview clean

VUEPRESS_IMG=docker.onedata.org/vuepress-compiler:v1

all: build

build:
	docker run --rm -v `pwd`:/vuepress -v `pwd`/yarn-cache:/usr/local/share/.cache:delegated ${VUEPRESS_IMG} build

package:
	cd docs/.vuepress/dist &&\
	tar zcf ../../../onedata-documentation.tar.gz .

preview:
	docker run --rm -p 8080:8080 -it -v `pwd`:/vuepress -v `pwd`/yarn-cache:/usr/local/share/.cache:delegated ${VUEPRESS_IMG} preview

submodules:
	git submodule sync --recursive ${submodule}
	git submodule update --init --recursive ${submodule}

build-native:
	yarn docs:build

preview-native:
	yarn docs:dev

install-native:
	yarn add -D vuepress

clean:
	@rm -rf node_modules package-lock.json yarn-cache docs/.vuepress/dist yarn.lock
