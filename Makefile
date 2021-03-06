.PHONY: all build install-gitbook build-gitbook build-swagger-api-docs package

all: build

build: install-gitbook build-gitbook 

preview: install-gitbook build-gitbook
	@bash ./bin/serve-gitbook.sh

install-gitbook:
	@bash ./bin/build-docs.sh install-gitbook

build-gitbook:
	@bash ./bin/build-docs.sh build-gitbook
	@bash ./bin/put-release-html.sh

submodules:
	git submodule sync --recursive ${submodule}
	git submodule update --init --recursive ${submodule}

package:
	cd _book && tar zcf ../onedata-documentation.tar.gz .

clean:
	@rm -rf node_modules _book package-lock.json

codetag-tracker:
	./bamboos/scripts/codetag-tracker.sh --branch=${BRANCH} --excluded-dirs=_book,gitbook_cache,node_modules
