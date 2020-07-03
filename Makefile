.PHONY: all build install-gitbook build-gitbook build-swagger-api-docs

all: build

build: install-gitbook build-gitbook 

preview: install-gitbook build-gitbook
	@bash ./bin/serve-gitbook.sh

install-gitbook:
	@bash ./bin/build-docs.sh install-gitbook

build-gitbook:
	@bash ./bin/build-docs.sh build-gitbook

submodules:
	git submodule sync --recursive ${submodule}
	git submodule update --init --recursive ${submodule}

clean:
	@rm -rf node_modules _book package-lock.json
