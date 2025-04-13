#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<- EOSQL
    CREATE DATABASE kreda_server;
    REVOKE ALL PRIVILEGES ON DATABASE kreda_server FROM public;
    CREATE ROLE "kreda_server_admin" WITH LOGIN PASSWORD 'qwerty1!';
    CREATE ROLE "kreda_server_user" WITH LOGIN PASSWORD 'qwerty1!';
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "kreda_server" <<- EOSQL
    GRANT ALL PRIVILEGES ON DATABASE kreda_server TO "kreda_server_admin";
    GRANT ALL PRIVILEGES ON SCHEMA public TO "kreda_server_admin" WITH GRANT OPTIONS;
    ALTER DEFAULT PRIVLEGES IN SCHEMA public GRANT ALL ON TABLES TO "kreda_server_admin";
    ALTER DEFAULT PRIVLEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO "kreda_server_admin";
    ALTER DEFAULT PRIVLEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO "kreda_server_admin";
    ALTER DEFAULT PRIVLEGES FOR ROLE "kreda_server_admin" GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO "kreda_server";
    ALTER DEFAULT PRIVLEGES FOR ROLE "kreda_server_admin" GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO "kreda_server";

    GRANT CONNECT ON DATABASE kreda_server TO "kreda_server_user";
    GRANT USAGE ON SCHEMA public to "kreda_server_user";
EOSQL