#!/bin/sh
# papermc.sh
# Downloads the latest PaperMC server jar for the specified Minecraft version.

set -e

PAPERMC_VERSION=$1

PAPERMC_API_ENDPOINT="https://papermc.io/api/v2/projects/paper/versions/$PAPERMC_VERSION/builds"

LATEST_BUILD=$(curl -s "$PAPERMC_API_ENDPOINT" | jq -r '.builds[-1]')
PAPERMC_BUILD=$(jq -nr "$LATEST_BUILD | .build")
PAPERMC_JAR_NAME=$(jq -nr "$LATEST_BUILD | .downloads.application.name")
PAPERMC_JAR_SHA256=$(jq -nr "$LATEST_BUILD | .downloads.application.sha256")
PAPERMC_URL="$PAPERMC_API_ENDPOINT/$PAPERMC_BUILD/downloads/$PAPERMC_JAR_NAME"

echo "Downloading PaperMC version $PAPERMC_VERSION build $PAPERMC_BUILD"
curl -s -o papermc.jar "$PAPERMC_URL"
echo "$PAPERMC_JAR_SHA256  papermc.jar" | sha256sum -c - || exit 1