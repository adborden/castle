import os
import ssl
import urllib.request

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_podman_is_installed(host):
    package = host.package("podman")
    assert package.is_installed


def test_vault_container_file_exists(host):
    f = host.file("/etc/containers/systemd/vault.container")
    assert f.exists
    assert f.user == "root"
    assert f.group == "root"


def test_vault_config_file_exists(host):
    f = host.file("/etc/vault/config.hcl")
    assert f.exists
    assert f.user == "root"
    assert f.group == "root"


def test_vault_user(host):
    u = host.user("vault")
    assert u.exists


def test_vault_group(host):
    g = host.group("vault")
    assert g.exists


def test_vault_config_dir(host):
    f = host.file("/etc/vault")
    assert f.exists
    assert f.is_directory
    assert f.mode == 0o755


def test_vault_data_dir(host):
    f = host.file("/var/lib/vault")
    assert f.exists
    assert f.is_directory
    assert f.mode == 0o755
    assert f.user == "vault"
    assert f.group == "vault"


def test_vault_server(host):
    s = host.socket("tcp://127.0.0.1:8200")
    assert s.is_listening


def test_vault_config(host):
    c = host.file("/etc/vault/config.hcl")
    assert (
        "True" not in c.content_string
    ), "Booleans must be converted to hcl boolean with to_json"
    assert (
        "False" not in c.content_string
    ), "Booleans must be converted to hcl boolean with to_json"


def test_vault_response(host):
    noverify = ssl._create_unverified_context()
    r = urllib.request.urlopen("https://localhost:8200/ui/", context=noverify)
    assert r.status == 200
