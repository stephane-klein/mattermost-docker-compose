# docker-compose files to deploy Mattermost

Project status: unstable, need more testing and peer review, see [issues](https://github.com/stephane-klein/mattermost-docker-compose/issues)

`docker-compose.yml` files to deploy [Mattermost](https://mattermost.com/):

- [`playground/`](playground/) to deploy Mattermost locally
- [`prod/`](prod) to deploy Mattermost on production

Deployment features:

- [x] based on [offical Mattermost Docker images](https://hub.docker.com/u/mattermost)
- [x] Alpine PostgreSQL 12.2
- [x] Backup system (optionnal)
  - [x] [Restic](https://github.com/restic/restic) to backup media data files to S3 compatible system
  - [x] [wal-g](https://github.com/wal-g/wal-g/) to backup PostgreSQL database to S3 compatible system
- [x] [Postfix](https://github.com/MarvAmBass/docker-versatile-postfix) to send mails (optionnal)

## Why this project?

To share my current Mattermost deployment system.

## Hosting provider

At this time, I like to host my services with success:

- on [Start-2-S-SSD](https://www.scaleway.com/en/dedibox/start/start-2-s-ssd/) Scaleway Dedibox server
- and push my backup on [Scaleway Object Storage](https://www.scaleway.com/en/object-storage/)

(This message isn't sponsored)