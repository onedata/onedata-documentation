build:
	@bash ./bin/build.sh

all: build

clean:
	@rm -rf node_modules _book package-lock.json
