.PHONY: build diff deploy setup

CONTAINER_IMAGE ?= ghcr.io/adborden/castle
CONTAINER_PLATFORMS ?= linux/amd64,linux/arm64
CONTAINER_TAG ?= latest

DEFAULT_GOAL: test

setup:
	poetry install --with=dev

diff:
	ansible-playbook --diff --check site.yaml

lint:
	poetry run ansible-lint -v site.yaml
deploy:
	ansible-playbook site.yaml

build:
	docker buildx build . --tag $(CONTAINER_IMAGE):$(CONTAINER_TAG) --platform $(CONTAINER_PLATFORMS) --load $(DOCKER_BUILD_ARGS)

test:
	poetry run molecule test

publish: DOCKER_BUILD_ARGS := $(DOCKER_BUILD_ARGS) --push
publish: build
