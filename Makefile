.PHONY: check deploy lint setup test

DEFAULT_GOAL: test

check:
	ansible-playbook --diff --check site.yaml

deploy:
	poetry run ansible-playbook site.yaml

lint:
	poetry run ansible-lint

setup:
	poetry install --with=dev
	poetry run ansible-galaxy install -r requirements.yaml --force

test:
	poetry run molecule test
	cd roles/vault && poetry run molecule test
