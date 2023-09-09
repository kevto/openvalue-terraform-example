#!/bin/sh
rm -rf dist
ng build -c production
docker build -t europe-west1-docker.pkg.dev/$2/$3/jworld-app:$1 .
docker push europe-west1-docker.pkg.dev/$2/$3/jworld-app:$1
