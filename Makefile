.PHONY: build test hh_autoload format

build:
	docker build -t mwildehahn/hack-graphql .

install: build
	docker run -v `pwd`:/app -it mwildehahn/hack-graphql composer install

update: build
	docker run -v `pwd`:/app -it mwildehahn/hack-graphql composer update

hh_autoload:
	docker run -v `pwd`:/app -it mwildehahn/hack-graphql ./vendor/bin/hh-autoload

test:
	docker run -v `pwd`:/app -it mwildehahn/hack-graphql ./vendor/bin/hacktest tests

format:
	docker run -v `pwd`:/app -it mwildehahn/hack-graphql find {src,tests} -type f -exec hackfmt -i {} \;