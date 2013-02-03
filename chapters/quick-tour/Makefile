all: build test-build

build:
	coffee -c -o lib src

test-build:
	coffee -c -o test/lib test/src

watch:
	coffee -o lib -cw src

test-watch:
	coffee -o test/lib -cw test/src

.PHONY: build test-build clean watch test-watch
