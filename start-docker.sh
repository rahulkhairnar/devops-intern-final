#!/usr/bin/env bash
set -euo pipefail

# start containerd if absent
if ! pgrep -x containerd > /dev/null; then
  nohup /usr/bin/containerd > ~/containerd.out 2>&1 &
  sleep 1
fi

# start dockerd if absent
if ! pgrep -x dockerd > /dev/null; then
  # ensure socket dir exists
  sudo mkdir -p /var/run/docker
  sudo chown root:root /var/run/docker || true
  nohup /usr/bin/dockerd --containerd=/run/containerd/containerd.sock --host=unix:///var/run/docker.sock > ~/dockerd.out 2>&1 &
  sleep 1
fi

# quick sanity
ps -ef | egrep 'dockerd|containerd|containerd-shim' --color=auto
ls -l /run/containerd/containerd.sock /var/run/docker.sock || true
echo "Docker server version: $(sudo docker info --format '{{.ServerVersion}}' 2>/dev/null || echo 'docker daemon not responding')"
