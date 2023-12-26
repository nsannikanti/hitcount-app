#!/bin/bash
git clone https://github.com/socgenaws/hitcount-app.git
cd hitcount-app
docker-compose up -d
docker-compose ps 
rm -f /tmp/hitcount-app
