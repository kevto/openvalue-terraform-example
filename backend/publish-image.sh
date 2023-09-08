#!/bin/sh
mvn clean package
docker build -t europe-west1-docker.pkg.dev/$2/$3/jworld-api:$1 .
docker push europe-west1-docker.pkg.dev/$2/$3/jworld-api:$1

