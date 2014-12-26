#!/bin/bash
set -e

if [ "$1" = 'postgres' ]; then
        chown -R postgres "$PGDATA"

        if [ -z "$(ls -A "$PGDATA")" ]; then
                gosu postgres initdb

                sed -ri "s/^#(listen_addresses\s*=\s*)\S+/\1'*'/" "$PGDATA"/postgresql.conf

                # check password first so we can ouptut the warning before postgres
                # messes it up
                #if [ "$POSTGRES_PASSWORD" ]; then
                #       pass="PASSWORD '$POSTGRES_PASSWORD'"
                #       authMethod=md5
                #else
                        # The - option  suppresses leading tabs but *not* spaces. :)
                #       cat >&2 <<-'EOWARN'
                #               ****************************************************
                #               WARNING: No password has been set for the database.
                #                        Use "-e POSTGRES_PASSWORD=password" to set
                #                        it in "docker run".
                #               ****************************************************
                #       EOWARN

                #       pass=
                #       authMethod=trust
                #fi

                #: ${POSTGRES_USER:=postgres}
                #if [ "$POSTGRES_USER" = 'postgres' ]; then
                #       op='ALTER'
                #else
                #       op='CREATE'
                #       gosu postgres postgres --single -E <<-EOSQL
                #               CREATE DATABASE "$POSTGRES_USER"
                #       EOSQL
                #fi

                #gosu postgres postgres --single <<-EOSQL
                #       $op USER "$POSTGRES_USER" WITH SUPERUSER $pass
                #EOSQL
                #{ echo; 
                su postgres -c "psql -c \"CREATE USER confine PASSWORD 'confine';\""
                su postgres -c "psql -c \"CREATE DATABASE controller OWNER confine;\""

                echo "host all all  0.0.0.0/0 trust"  >> "$PGDATA"/pg_hba.conf

                #if [ -d /docker-entrypoint-initdb.d ]; then
                #       for f in /docker-entrypoint-initdb.d/*.sh; do
                #               [ -f "$f" ] && . "$f"
                #       done
                #fi
        fi

        exec gosu postgres "$@"
fi

exec "$@"

