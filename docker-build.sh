#! /bin/sh

docker build -t biow0lf/evemonk:dev . --no-cache --progress plain
docker push biow0lf/evemonk:dev
