.PHONY: check deploy lint setup test

DEFAULT_GOAL: test

check:
	ansible-playbook --diff --check site.yaml

deploy:
	poetry run ansible-playbook site.yaml

lint:
	poetry run ansible-lint site.yaml

setup:
	poetry install --with=dev
	poetry run ansible-galaxy install -r requirements.yaml --force

test:
	cd roles/castle_pull && poetry run molecule test
	cd roles/vault && poetry run molecule test
