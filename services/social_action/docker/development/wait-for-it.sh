#!/bin/sh
# wait-for-postgres.sh
set -e


until  psql  "postgresql://root:root@postgres/postgres"  -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done
#echo "SELECT 'CREATE DATABASE $DB_DATABASE' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '$DB_DATABASE')\gexec"| PGPASSWORD=$DB_PASSWORD psql -h  "$DB_HOST" -U  "$DB_USERNAME"
echo "SELECT 'CREATE DATABASE social_action_development' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'social_action_development')\gexec"| PGPASSWORD="root" psql -h  "postgres" -U "root" -d "postgres"

>&2 echo "Postgres is up - executing command"

./mvnw -D flyway.configFiles=./src/main/resources/application.properties flyway:migrate
./mvnw spring-boot:run
