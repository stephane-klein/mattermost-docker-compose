#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

export $(egrep -v '^#' .env | xargs)

export COMPOSE_FILE="docker-compose.yml"

if [[ "$ENABLE_WALG" == 1 ]]; then
    export COMPOSE_FILE="${COMPOSE_FILE}:docker-compose.wal-g.yml"
fi

if [[ "$ENABLE_POSTFIX" == 1 ]]; then
    export COMPOSE_FILE="${COMPOSE_FILE}:docker-compose.postfix.yml"
fi

if [[ "$ENABLE_RESTIC" == 1 ]]; then
    export COMPOSE_FILE="${COMPOSE_FILE}:docker-compose.restic.yml"
fi

docker-compose pull

docker-compose up -d db

if [[ "$ENABLE_POSTFIX" == 1 ]]; then
    docker-compose up -d postfix
fi

docker-compose -f docker-compose.yml -f docker-compose.wait.yml run --rm wait_db

if [[ ! -f config/config.json ]]; then
    # Generate default Mattermost config file in config/config.json
    docker-compose run --rm app mattermost config >> /dev/null

    ./scripts/update-mattermost-config-file.sh
fi

docker-compose up -d app
docker-compose -f docker-compose.yml -f docker-compose.wait.yml run --rm wait_app

docker-compose up -d web

if [[ "$ENABLE_RESTIC" == 1 ]]; then
    docker-compose up -d restic
fi

docker-compose ps

echo "Open your browser on ${MATTERMOST_APP_SITE_URL}"