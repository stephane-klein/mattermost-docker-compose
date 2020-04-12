#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

export $(egrep -v '^#' .env | xargs)

export COMPOSE_FILE="docker-compose.yml"

# Restore media datas
AWS_ACCESS_KEY_ID= restic -r s3:

(
    AWS_ACCESS_KEY_ID=${RESTIC_AWS_ACCESS_KEY_ID}
    AWS_SECRET_ACCESS_KEY=${RESTIC_AWS_SECRET_ACCESS_KEY}
    restic restore latest --target ${MATTERMOST_APP_VOLUME_DATA}/backup/
    cp -r ${MATTERMOST_APP_VOLUME_DATA}/backup/data/* ${MATTERMOST_APP_VOLUME_DATA}/
    rm -rf ${MATTERMOST_APP_VOLUME_DATA}/backup/
)

if [[ "$ENABLE_WALG" == 1 ]]; then
    export COMPOSE_FILE="${COMPOSE_FILE}:docker-compose.wal-g.yml"
else
    echo "ENABLE_WALG is disable then restoration is impossible"
    exit 1
fi

read -p "Are you sure to delete current Mattermost database and media? (Y)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker-compose stop
    rm -rf ${POSTGRES_VOLUME_DATA}
else
    exit 0
fi

docker-compose run \
    -e WALG_PGP_KEY_PATH=${WALG_PGP_SECRET_KEY_PATH} \
    --rm db \
    sh -c '/wal-g backup-fetch $PGDATA LATEST; touch $PGDATA/recovery.signal'

# ./scripts/up.sh