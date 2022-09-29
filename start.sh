#!/bin/sh
# start.sh
# Starts the server.

set -e

cd /data

if [ ! -f "eula.txt" ]; then
    echo "eula=true" > eula.txt
fi

echo "Starting PaperMC server..."
exec java "-Xms${JAVA_MEM:-1G}" "-Xmx${JAVA_MEM:-1G}" ${JAVA_OPTS} -jar /opt/papermc/papermc.jar nogui