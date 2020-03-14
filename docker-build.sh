#! /bin/sh

docker build -t biow0lf/evemonk:master . --no-cache
docker push biow0lf/evemonk:master
