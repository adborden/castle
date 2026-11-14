import os
import testinfra.utils.ansible_runner

import pytest

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_podman_is_installed(host):
    package = host.package("podman")
    assert package.is_installed


@pytest.mark.parametrize(
    "filename",
    [
        "dnsmasq.container",
        "dnsmasq.image",
    ],
)
def test_container_files_exists(host, filename):
    f = host.file(f"/etc/containers/systemd/{filename}")
    assert f.exists
    assert f.mode == 0o644
    assert f.user == "root"
    assert f.group == "root"


def test_dnsmasq_config_exists(host):
    f = host.file("/etc/dnsmasq.conf")
    assert f.exists
    assert f.mode == 0o644
    assert f.user == "root"
    assert f.group == "root"
