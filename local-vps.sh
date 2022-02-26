#!/usr/bin/env bash
set -euo pipefail

docker run -d --rm \
    --name local-vps-$PORT \
    -p $PORT:$PORT \
    -v /var/run/docker.sock:/var/run/docker.sock \
    local-vps $PORT
