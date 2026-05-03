.PHONY: build diff deploy setup

CONTAINER_IMAGE ?= ghcr.io/adborden/castle
CONTAINER_TAG ?= latest

setup:
	poetry install

diff:
	ansible-playbook --diff --check site.yaml

deploy:
	ansible-playbook site.yaml

build:
	docker build . --tag $(CONTAINER_IMAGE):$(CONTAINER_TAG) --load $(DOCKER_BUILD_ARGS)

publish: DOCKER_BUILD_ARGS = $(DOCKER_BUILD_ARGS) --push
publish: build
