#!/bin/bash

# Download outline
wget -O Outline.tar.gz https://github.com/outline/outline/archive/refs/tags/v0.67.0-pre.1.tar.gz

tar xzf Outline.tar.gz
# Change outline folder name
mv outline* outline

# Install nodejs
nvm install lts/gallium && nvm use lts/gallium

sudo apt-get update -q
sudo apt-get install postgresql redis -y

# Start redis and postgresql
sudo service redis-server start
sudo service postgresql start

# Set change postgres password
sudo su -c "psql -c \"ALTER USER postgres WITH PASSWORD 'postgres'\"" postgres

# Install nodejs packages
npm install -g yarn
cd outline && yarn install --frozen-lockfile && yarn build

# Change .env setup
cp .env.sample .env
sed -i 's/user:pass/postgres:postgres/' .env
sed -i "s/SECRET\_KEY=.*/SECRET\_KEY=$(openssl rand -hex 32)/" .env
sed -i "s/UTILS\_SECRET=.*/UTILS\_SECRET=$(openssl rand -hex 32)/" .env

# Set database
yarn sequelize db:create --env=production-ssl-disabled
yarn sequelize db:migrate --env=production-ssl-disabled
