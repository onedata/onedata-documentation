.PHONY: all build install-gitbook build-gitbook build-swagger-api-docs

all: build

build: install-vuepress build-vuepress 

preview: preview-vuepress

preview-gitbook: install-gitbook build-gitbook
	@bash ./bin/serve-gitbook.sh

install-gitbook:
	@bash ./bin/build-docs.sh install-gitbook

build-gitbook:
	@bash ./bin/build-docs.sh build-gitbook

install-vuepress:
	@bash ./bin/build-docs.sh install-vuepress

build-vuepress:
	@bash ./bin/build-docs.sh build-vuepress

package:
	cd vuepress/docs/.vuepress/dist &&\
	tar zcf ../../../../onedata-documentation.tar.gz .

preview-vuepress:
	docker run --rm --net host -it -v `pwd`/vuepress:/vuepress -v `pwd`/yarn-cache:/usr/local/share/.cache:delegated node:14.9 bash -c "cd /vuepress; yarn docs:dev"

submodules:
	git submodule sync --recursive ${submodule}
	git submodule update --init --recursive ${submodule}

clean:
	@rm -rf node_modules _book package-lock.json
