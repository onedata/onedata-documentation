build-gitbook:
	@bash ./bin/build-gitbook.sh

build-swagger-api-docs:
	@bash ./bin/build-swagger-api-docs.sh

build: build-gitbook build-swagger-api-docs

all: build

clean:
	@rm -rf node_modules _book package-lock.json

preview: build-gitbook
	@bash ./bin/serve-gitbook.sh
