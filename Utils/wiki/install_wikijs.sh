#!/bin/bash

# Download wikijs
wget https://github.com/Requarks/wiki/releases/latest/download/wiki-js.tar.gz
mkdir wiki
tar xzf wiki-js.tar.gz -C ./wiki
pushd ./wiki
mv config.sample.yml config.yml

# Change ID / PW in config
sed -i 's/user: .\+/user: postgres/' config.yml
sed -i 's/pass: .\+/pass: postgres/' config.yml

# Install nodejs 16.X
nvm install lts/gallium && nvm use lts/gallium

sudo apt-get update -q
sudo apt-get install postgresql -y

# Start postgresql
sudo service postgresql start

# Set change postgres password
sudo su -c "psql -c \"CREATE USER wikijs SUPERUSER\"" postgres
sudo su -c "psql -c \"ALTER USER wikijs WITH PASSWORD 'wikijsrocks'\"" postgres

popd

cat >nohup.sh <<EOF
export NVM_DIR=${HOME}/.nvm
echo "Started at $(date)"
. ${NVM_DIR}/nvm.sh && nvm use lts/gallium \
&& cd wiki && npm run start &
EOF
