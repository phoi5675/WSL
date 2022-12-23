# Planka

## Installation

1. Install dependencies

   - [Node.js](https://learn.microsoft.com/ko-kr/windows/dev-environment/javascript/nodejs-on-wsl)
   - [Postgresql](https://www.postgresql.org/download/linux/ubuntu/) or

   ```bash
   sudo apt-get update && sudo apt-get install postgresql
   ```

   - **start postgresql if service not running**

1. Setup postgresql

   - Change password

   ```bash
   ALTER USER postgresql WITH PASSWORD 'postgresql'
   ```

   - Edit /etc/postgresql/12/main/pg_hba.conf

   ```bash
   # IPv4 local connections:
   host    all             all             127.0.0.1/32            md5
   ```

   to

   ```bash
   host    all             all             127.0.0.1/32            trust
   ```

1. [Clone repository](https://github.com/plankanban/planka#development)

1. Paste below to server/.env

```sh
# Required

BASE_URL=http://localhost:1337
DATABASE_URL=postgresql://postgres:postgres@localhost/planka
SECRET_KEY=d0853ae8ee41ebdb5872f4e4c46c9aa9

# Optional

TRUST_PROXY=0
TOKEN_EXPIRES_IN=365 # In days

# Do not edit this

TZ=UTC
```

1. (Optional) Add task scheduler to Windows Task Scheduler to start automatically when Windows boots

1. Create nohup.sh in /home/phoi/

```sh
#!/bin/bash
PATH="/home/phoi/.nvm/versions/node/v18.12.0/bin:$PATH"

cd planka && npm start
```
