# This script creates a new database user (from .env file)
# that has "create database" privileges. Application databases 
# (production + test) will be built via SQLAlchemy scripts:
echo "$PWD"
echo "$(ls -la)"
pg_pass=$(cat ./.env | grep PGPASSWORD | awk -F= '{print $2}')
DB_USERNAME=$(cat ./.env | grep DB_USERNAME | awk -F= '{print $2}')
DB_PASSWORD=$(cat ./.env | grep DB_PASSWORD | awk -F= '{print $2}')
# Set the postgres password environment variable
export PGPASSWORD="postgres"
# Create new DB user with appropriate permissions:
# psql -U postgres -h localhost -p 5432 -c "CREATE USER "$DB_USERNAME" with encrypted password '"$DB_PASSWORD"';"
# psql -U postgres -h localhost -p 5432 -c "GRANT USAGE ON SCHEMA public TO "$DB_USERNAME";"
# psql -U postgres -h localhost -p 5432 -c "ALTER USER "$DB_USERNAME" CREATEDB;"
psql -U postgres -h localhost -p 5432 -c "CREATE USER app_user with encrypted password '12345';"
psql -U postgres -h localhost -p 5432 -c "GRANT USAGE ON SCHEMA public TO app_user;"
psql -U postgres -h localhost -p 5432 -c "ALTER USER app_user CREATEDB;"