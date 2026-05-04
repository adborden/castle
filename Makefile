.PHONY: diff deploy lint setup test

DEFAULT_GOAL: test

diff:
	ansible-playbook --diff --check site.yaml

deploy:
	poetry run ansible-playbook site.yaml

lint:
	poetry run ansible-lint -v site.yaml

setup:
	poetry install --with=dev

test:
	poetry run molecule test
