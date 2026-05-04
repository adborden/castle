# castle

Ansible playbooks to manage all the nodes. Configures nodes with
ansible-pull so that nodes managed themselves and will converge on
the desired state.

## Features

- castle-pull systemd timer to keep nodes up to date

## Usage

Install dependencies to run the playbooks.

```bash
make setup
```

Deploy the playbooks.

```bash
make deploy
```

## Development

Install development dependencies.

```bash
make setup
```

Lint the playbooks.

```bash
make lint
```

Run the tests.

```bash
make test
```

## Runbooks

## TODO
