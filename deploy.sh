#!/bin/bash
if [ -d "hitcount-app" ]; then
  echo "hitcount-app does exist."
  rm -rf hitcount-app
fi
git clone https://github.com/nsannikanti/hitcount-app.git
cd hitcount-app
docker-compose stop
docker-compose rm 
docker-compose up -d
docker-compose ps 
