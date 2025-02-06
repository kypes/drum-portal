#!/bin/bash

set -e

# Remove a potentially pre-existing server.pid for Rails
rm -f /rails/tmp/pids/server.pid

# Function to wait for a service
wait_for_service() {
  local service=$1
  local host=$2
  local port=$3
  local max_attempts=30
  local attempt=1

  echo "Waiting for $service..."
  
  case $service in
    "postgres")
      until pg_isready -h $host -p $port -U drum_portal || [ $attempt -eq $max_attempts ]; do
        echo "Waiting for PostgreSQL... (Attempt $attempt/$max_attempts)"
        sleep 2
        attempt=$((attempt + 1))
      done
      ;;
    "redis")
      until redis-cli -h $host ping &>/dev/null || [ $attempt -eq $max_attempts ]; do
        echo "Waiting for Redis... (Attempt $attempt/$max_attempts)"
        sleep 2
        attempt=$((attempt + 1))
      done
      ;;
  esac

  if [ $attempt -eq $max_attempts ]; then
    echo "Failed to connect to $service after $max_attempts attempts"
    exit 1
  fi

  echo "$service is up and running!"
}

# Wait for required services
wait_for_service "postgres" "postgres" "5432"
wait_for_service "redis" "redis" "6379"

# Set up database and assets if needed
if [ "${RAILS_ENV}" = "development" ]; then
  # Check if this is the web container
  if [[ "$*" == *"rails server"* ]]; then
    echo "Running database migrations..."
    bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:setup

    echo "Seeding database..."
    bundle exec rails db:seed 2>/dev/null || echo "Seeding failed, continuing..."

    echo "Building Tailwind CSS..."
    yarn build:css
  fi
fi

# Ensure correct permissions for tmp and log directories
mkdir -p /rails/tmp /rails/log
chmod -R 777 /rails/tmp /rails/log
chown -R 1000:1000 /rails/tmp /rails/log

# Then exec the container's main process
exec "$@" 