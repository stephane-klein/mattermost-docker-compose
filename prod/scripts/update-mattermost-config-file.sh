#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

if [ -f config/config.json ]; then
    # Set SMTP configuration in config/config.json
    export $(egrep -v '^#' .env | xargs)

    jq ".ServiceSettings.SiteURL = \"${MATTERMOST_APP_SITE_URL}\"" config/config.json > config/config.json.tmp && mv config/config.json.tmp config/config.json

    jq ".EmailSettings.FeedbackName = \"${MATTERMOST_APP_FEEDBACK_NAME}\"" config/config.json > config/config.json.tmp && mv config/config.json.tmp config/config.json
    jq ".EmailSettings.FeedbackEmail = \"${MATTERMOST_APP_FEEDBACK_EMAIL}\"" config/config.json > config/config.json.tmp && mv config/config.json.tmp config/config.json
    jq ".EmailSettings.ReplyToAddress = \"${MATTERMOST_APP_REPLY_TO_ADDRESS}\"" config/config.json > config/config.json.tmp && mv config/config.json.tmp config/config.json
    jq ".EmailSettings.FeedbackOrganization = \"${MATTERMOST_APP_FEEDBACK_ORGANIZATION}\"" config/config.json > config/config.json.tmp && mv config/config.json.tmp config/config.json

    jq ".EmailSettings.SMTPUsername = \"${MATTERMOST_APP_SMTP_USERNAME}\"" config/config.json > config/config.json.tmp && mv config/config.json.tmp config/config.json
    jq ".EmailSettings.SMTPPassword = \"${MATTERMOST_APP_SMTP_PASSWORD}\"" config/config.json > config/config.json.tmp && mv config/config.json.tmp config/config.json
    jq ".EmailSettings.SMTPServer = \"${MATTERMOST_APP_SMTP_SERVER}\"" config/config.json > config/config.json.tmp && mv config/config.json.tmp config/config.json
    jq ".EmailSettings.SMTPPort = \"${MATTERMOST_APP_SMTP_PORT}\"" config/config.json > config/config.json.tmp && mv config/config.json.tmp config/config.json
fi