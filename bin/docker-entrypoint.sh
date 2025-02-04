#!/bin/bash

set -e

# Remove a potentially pre-existing server.pid for Rails
rm -f /rails/tmp/pids/server.pid

# Wait for PostgreSQL
until pg_isready -h postgres -p 5432 -U postgres
do
  echo "Waiting for PostgreSQL..."
  sleep 2
done
echo "PostgreSQL is up and running!"

# Wait for Redis
until redis-cli -h redis ping
do
  echo "Waiting for Redis..."
  sleep 2
done
echo "Redis is up and running!"

# Set up database and assets if needed
if [ "${RAILS_ENV}" = "development" ]; then
  # Check if this is the web container (the one running the Rails server)
  if [[ "$*" == *"rails server"* ]]; then
    echo "Running database setup..."
    bundle exec rails db:prepare

    echo "Building Tailwind CSS..."
    yarn build:css
  fi
fi

# Then exec the container's main process
exec "$@" 