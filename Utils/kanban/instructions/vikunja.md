# Vikunja

## Installation

- [Install backend](https://vikunja.io/docs/install-backend/)
- [Install frontend](https://vikunja.io/docs/install-frontend/#nginx)
- [reverse proxy](https://vikunja.io/docs/reverse-proxy/)
- **port 80 may be blocked, so use other port instead.**
- **If got 400 error when creating first namespace, use unstable version(FE / API)**

## Run server

- run command below @ ~

```bash
echo 'cd /opt/vikunja && /usr/bin/vikunja &' > nohup.sh
```

- install postgresql, nginx
- edit /etc/vikunja/config.yml
  - database to `postgres`
  - timezone to `ROK`
  - interface
    - If you don't want to change interface, use [nginx reverse proxy](https://vikunja.io/docs/reverse-proxy/)
- add xml file to task scheduler

## Additional setup

To add media server manually, paste below code to `/etc/nginx/sites-enabled/default`
and run `sudo nginx -s reload`

```nginx
server {
  listen 8000;
  server_name localhost;

  root /media;

  location ~ ^/image/.*(png|jpg|jpeg|gif|ico|swf)$ {
    break;
  }
}
```

- Usage(in markdown)

```markdown
![Image_name](http://localhost:8000/image/image_name.jpg)
```

## Backup and restore

- Backup

```bash
# Login as postgres
pg_dump vikunja > dumpfile
```

- Restore  
  \* Create database `vikunja` first!

```bash
# Login as postgres
psql vikunja < dumpfile
```
