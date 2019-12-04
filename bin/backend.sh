#! /bin/sh

rm -rf /shared/*

cp -R /app/public/ /shared/

if [ -n "${SENTRY_AUTH_TOKEN}" ]; then
  sentry-cli releases new -p evemonk-backend "$COMMIT_SHA"

  sentry-cli releases set-commits "$COMMIT_SHA" --commit "evemonk/evemonk@$COMMIT_SHA"

  sentry-cli releases deploys "$COMMIT_SHA" new -e production
fi

bundle exec newrelic deployment --revision="$COMMIT_SHA"

wait-for-it "redis:6379" -- echo "Redis up and running"

wait-for-it "memcached:11211" -- echo "Memcached up and running"

wait-for-it "postgresql:5432" -- echo "PostgreSQL up and running"

wait-for-it "elasticsearch:9200" -- echo "Elastic up and running"

bundle exec puma -C config/puma.rb
