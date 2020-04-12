#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

docker-compose pull

docker-compose up -d db mailhog
docker-compose -f docker-compose.yml -f docker-compose.wait.yml run --rm wait_db

if [ ! -f config/config.json ]; then
    # Generate default Mattermost config file in config/config.json
    docker-compose run --rm app mattermost config

    ./scripts/update-mattermost-config-file.sh
fi

docker-compose up -d app
docker-compose -f docker-compose.yml -f docker-compose.wait.yml run --rm wait_app

docker-compose up -d web

docker-compose ps

echo "Open your browser on http://127.0.0.1:8080"