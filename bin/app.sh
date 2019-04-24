#! /bin/sh

wait-for "postgresql:5432" -- bundle exec rails db:migrate
wait-for "${POSTGRES_HOST}:5432" -- bundle exec puma -C config/puma.rb

