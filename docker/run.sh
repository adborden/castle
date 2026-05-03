#!/bin/sh

set -o errexit
#set -o pipefail
set -o nounset

: "${ANSIBLE_PULL_ARGS:=}"

exec ansible-pull --url "${ANSIBLE_PULL_REPOSITORY}" --checkout "${ANSIBLE_PULL_REF}" ${ANSIBLE_PULL_ARGS} "${ANSIBLE_PULL_PLAYBOOK}"
