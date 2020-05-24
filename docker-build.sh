#! /bin/sh

docker build -t "biow0lf/evemonk:$(cat .version)" . --no-cache
docker push "biow0lf/evemonk:$(cat .version)"
