gosu postgres postgres --single -E <<-EOSQL
CREATE USER confine PASSWORD 'confine'
EOSQL

gosu postgres postgres --single -E <<-EOSQL
CREATE DATABASE controller OWNER confine
EOSQL


