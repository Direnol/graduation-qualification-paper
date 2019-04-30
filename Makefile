.PHONY: tc cli clean clean-all raw-clean raw-clean-all build raw-build

TOOLCHAIN_NAME=latex-build
USE_TTY = -it
DOCKER_OPTS=--rm ${USE_TTY} \
	-v $(shell pwd):/data \
	--env UID=$(shell id -u) \
	--env GID=$(shell id -g) \
	--user user:$(shell id -u):$(shell id -g) \
	${TOOLCHAIN_NAME}

tc:
	@docker build \
		--tag=${TOOLCHAIN_NAME} \
		.

cli:
	@docker run ${DOCKER_OPTS}

build clean clean-all:
	@docker run ${DOCKER_OPTS} \
		make raw-$@

################

raw-build:
	latexmk -xelatex main.tex

raw-clean:
	latexmk -c

raw-clean-all:
	latexmk -C
