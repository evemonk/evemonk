#! /bin/sh

sed -i "s/#shared_preload_libraries = ''/shared_preload_libraries = 'pg_stat_statements'/g" /var/lib/postgresql/data/postgresql.conf

sed -i "s/#track_activity_query_size = 1024/track_activity_query_size = 2048\npg_stat_statements.track = all\npg_stat_statements.max = 10000/g" /var/lib/postgresql/data/postgresql.conf
