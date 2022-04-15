#!/usr/bin/env bash
set -euo pipefail

VERSION="1.5.4505"
SYSTEMCTL_NAME="docker-systemctl-replacement"
IMAGE_NAME="atlekbai/local-vps"

URL_ARCHIVE="https://github.com/gdraheim/docker-systemctl-replacement/archive/refs/tags/v$VERSION.zip"
ARCHIVE_NAME="$SYSTEMCTL_NAME.zip"
UNPACKED_DIRECTORY="$SYSTEMCTL_NAME-$VERSION"

[ -f "$ARCHIVE_NAME" ] || curl -sL -o $ARCHIVE_NAME $URL_ARCHIVE
[ -d "$UNPACKED_DIRECTORY" ] || unzip $ARCHIVE_NAME > /dev/null

[ -f "journalctl.py" ] || mv "$UNPACKED_DIRECTORY/files/docker/journalctl3.py" journalctl.py
[ -f "systemctl.py" ] || mv "$UNPACKED_DIRECTORY/files/docker/systemctl3.py" systemctl.py

docker build -t $IMAGE_NAME --platform=linux/amd64 .

rm -rf "$ARCHIVE_NAME" "$UNPACKED_DIRECTORY" journalctl.py systemctl.py
