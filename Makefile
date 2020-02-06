install-gitbook:
	@bash ./bin/build-docs.sh install-gitbook

build-gitbook:
	@bash ./bin/build-docs.sh build-gitbook

build-swagger-api-docs:
	@bash ./bin/build-docs.sh build-redoc

build: install-gitbook build-gitbook build-swagger-api-docs

all: build

clean:
	@rm -rf node_modules _book package-lock.json

preview: install-gitbook build-gitbook
	@bash ./bin/serve-gitbook.sh
