#! /bin/bash

gzcat backup-2019-12-27.sql.gz | docker exec -i evemonk_postgresql psql -U postgres
