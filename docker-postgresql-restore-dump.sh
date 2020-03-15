#! /bin/bash

gzcat backup-2020-01-21.sql.gz | docker exec -i evemonk_postgresql psql -U postgres
