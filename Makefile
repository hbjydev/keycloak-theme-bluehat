all: build

clean:
	rm -rf dist/

css:
	npm run build-css -- -m

copy:
	mkdir dist
	cp -r src/common src/login dist/

build: clean css copy
	cd dist && tar -czvf /tmp/bluehat.tar.gz ./common ./login
	cd dist && mv /tmp/bluehat.tar.gz .
