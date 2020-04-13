# Deploy Mattermost on production

Prerequisite on server:

- [Docker Engine](https://docs.docker.com/engine/) (tested with version `19.03.8`)
- [Docker Compose](https://docs.docker.com/compose/) (tested version `1.25.4`)
- [jq](https://github.com/stedolan/jq)
- [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy) and [docker-letsencrypt-nginx-proxy-companion](https://github.com/nginx-proxy/docker-letsencrypt-nginx-proxy-companion) services to manage VirtualHost and Let's Encrypt

Copy `/prod/` folder content on your server, for instance in `/srv/mattermost/` folder.

```
$ cp env.sample .env
```

Configure `.env` file with your parameter.

```
$ ./scripts/up.sh
```

Open your browser on:

- Mattermost: https://example.com

## Notes

- For now, the secrets are stored in `.env` file on the server then I don't deploy this project VM instance but rather on Baremetal instance ([see](../#hosting-provider))