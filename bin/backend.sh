#! /bin/sh

rm -rf /shared/*

cp -R /app/public/ /shared/

sentry-cli releases new -p evemonk-backend "$COMMIT_SHA"

#sentry-cli releases set-commits --auto "$COMMIT_SHA"

sentry-cli releases set-commits "$COMMIT_SHA" --commit "evemonk@$COMMIT_SHA"

sentry-cli releases deploys "$COMMIT_SHA" new -e production

wait-for-it "redis:6379" -- echo "Redis up and running"

wait-for-it "memcached:11211" -- echo "Memcached up and running"

wait-for-it "postgresql:5432" -- echo "PostgreSQL up and running"

wait-for-it "elasticsearch:9200" -- echo "Elastic up and running"

bundle exec puma -C config/puma.rb
