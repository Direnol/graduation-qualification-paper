.PHONY: tc cli clean clean-all raw-clean raw-clean-all build raw-build

TOOLCHAIN_NAME=latex-build
USE_TTY = -it
DOCKER_OPTS=--rm ${USE_TTY} \
	-v $(shell pwd):/data \
	--env UID=$(shell id -u) \
	--env GID=$(shell id -g) \
	--user user:$(shell id -u):$(shell id -g) \
	${TOOLCHAIN_NAME}

ifdef IN_TRAVIS
	QUIET_DOCKER = --quiet
endif

tc:
	@docker build ${QUIET_DOCKER} \
		--tag=${TOOLCHAIN_NAME} \
		.

cli:
	@docker run ${DOCKER_OPTS}

build clean clean-all:
	@docker run ${DOCKER_OPTS} \
		make raw-$@

%.pdf: %.tex
	latexmk -interaction=nonstopmode -file-line-error -synctex=1 -xelatex -f $<

################

raw-build: report.pdf thesis.pdf

raw-clean:
	latexmk -c

raw-clean-all: raw-clean
	latexmk -CA
