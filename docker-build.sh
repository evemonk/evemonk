#! /bin/sh

docker build -t biow0lf/evemonk:dev . --no-cache --progress plain --build-arg COMMIT="$(git rev-parse HEAD)"
docker push biow0lf/evemonk:dev
