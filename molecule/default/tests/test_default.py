import os
import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_podman_is_installed(host):
    package = host.package("ansible")
    assert package.is_installed


def test_castle_pull_service_file_exists(host):
    f = host.file("/etc/systemd/system/castle-pull.service")
    assert f.exists
    assert f.user == "root"
    assert f.group == "root"


def test_castle_pull_timer_file_exists(host):
    f = host.file("/etc/systemd/system/castle-pull.timer")
    assert f.exists
    assert f.user == "root"
    assert f.group == "root"
