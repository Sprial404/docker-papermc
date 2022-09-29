#!/bin/sh
# entrypoint.sh
# Creates the user and group for the server, and then starts the server as that user.

set -e

DOCKER_USER='papermc'
DOCKER_GROUP='papermc'

if ! id -u "$DOCKER_USER" >/dev/null 2>&1; then
    USER_ID=${PUID:-9001}
    GROUP_ID=${PGID:-9001}
    echo "Creating user $DOCKER_USER with UID $USER_ID and GID $GROUP_ID"

    addgroup -g "$GROUP_ID" "$DOCKER_GROUP"
    adduser -D -H -u "$USER_ID" -G "$DOCKER_GROUP" -s /bin/sh --gecos "" "$DOCKER_USER"

    chown -vR "$DOCKER_USER:$DOCKER_GROUP" /opt/papermc
    chmod -vR ug+rwx /opt/papermc
    chown -vR "$DOCKER_USER:$DOCKER_GROUP" /data
fi

exec su-exec "$DOCKER_USER:$DOCKER_GROUP" $@
