# Task scheduler

Readme for task scheduler in wsl

---

# Vikunja

<details>
  <summary>Vikunja installations</summary>

## Installation

- [Install backend](https://vikunja.io/docs/install-backend/)
- [Install frontend](https://vikunja.io/docs/install-frontend/#nginx)
- [reverse proxy](https://vikunja.io/docs/reverse-proxy/)
- **port 80 may be blocked, so use other port instead.**
- **If got 400 error when creating first namespace, use unstable version(FE / API)**

## Run server

- run command below @ ~

```shell
echo 'cd /opt/vikunja && /usr/bin/vikunja &' > nohup.sh
```

- install postgresql, nginx
- edit /etc/vikunja/config.yml
  - database to `postgres`
  - timezone to `ROK`
- add xml file to task scheduler

## Additional setup

To add media server manually, paste below code to `/etc/nginx/sites-enabled/default`  
and run `sudo nginx -s reload`

```nginx
server {
  listen 8000;
  server_name localhost;

  root /home/${USER}/media; # Replace ${USER} with your username

  location ~ ^/image/.*(png|jpg|jpeg|gif|ico|swf)$ {
    break;
  }
}
```

</details>

# Focalboard

<details>
  <summary>Focalboard installation</summary>

## Installation

- [focalboard repo](https://github.com/mattermost/focalboard#mattermost-boards---now-available-as-a-free-cloud-server)
- [install focalboard on personal server](https://www.focalboard.com/download/personal-edition/ubuntu/)

## Run server

- run command below @ ~

```shell
echo 'cd /opt/focalboard && ./bin/focalboard-server &' > nohup.sh
```

- add xml file to task scheduler

</details>

# Planka

<details>
  <summary>Planka installation</summary>

## Installation

1. Install dependencies
   - [Node.js](https://learn.microsoft.com/ko-kr/windows/dev-environment/javascript/nodejs-on-wsl)
   - [Postgresql](https://www.postgresql.org/download/linux/ubuntu/) or
   ```shell
   sudo apt-get update && sudo apt-get install postgresql
   ```
   - **start postgresql if service not running**
1. Setup postgresql

   - Change password

   ```shell
   ALTER USER postgresql WITH PASSWORD 'postgresql'
   ```

   - Edit /etc/postgresql/12/main/pg_hba.conf

   ```shell
   # IPv4 local connections:
   host    all             all             127.0.0.1/32            md5
   ```

   to

   ```shell
   host    all             all             127.0.0.1/32            trust
   ```

1. [Clone repository](https://github.com/plankanban/planka#development)

1. Paste below to server/.env

```sh
## Required

BASE_URL=http://localhost:1337
DATABASE_URL=postgresql://postgres:postgres@localhost/planka
SECRET_KEY=d0853ae8ee41ebdb5872f4e4c46c9aa9

## Optional

# TRUST_PROXY=0
# TOKEN_EXPIRES_IN=365 # In days

## Do not edit this

TZ=UTC
```

1. (Optional) Add task scheduler to Windows Task Scheduler to start automatically when Windows boots

1. Create nohup.sh in /home/phoi/

```sh
#!/bin/bash
PATH="/home/phoi/.nvm/versions/node/v18.12.0/bin:$PATH"

cd planka && npm start
```

</details>

# Export image to tar(backup)

```sh
wsl --export <Distro> <Path\Filename.tar>
```

# External Links

- [WSL Linux images](https://learn.microsoft.com/ko-kr/windows/wsl/install-manual#downloading-distributions)
</summary>
