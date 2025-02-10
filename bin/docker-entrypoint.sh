#!/bin/bash
set -e

# Function to log messages
log() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Remove a potentially pre-existing server.pid for Rails
if [ -f /rails/tmp/pids/server.pid ]; then
  log "Removing stale server.pid file"
  rm -f /rails/tmp/pids/server.pid
fi

# Wait for PostgreSQL
until pg_isready -h postgres -p 5432 -U drum_portal; do
  log "Waiting for PostgreSQL..."
  sleep 2
done
log "PostgreSQL is up"

# Wait for Redis
until redis-cli -h redis ping &>/dev/null; do
  log "Waiting for Redis..."
  sleep 2
done
log "Redis is up"

# Always install gems
log "Installing Ruby dependencies..."
bundle config set --local path '/usr/local/bundle'
bundle config set --local jobs 4
bundle config set --local retry 3
bundle install

# Set up database if needed
if [ "${RAILS_ENV}" = "development" ]; then
  if [[ "$*" == *"rails server"* ]]; then
    log "Setting up development environment"
    bundle exec rails db:prepare
    bundle exec rails db:seed
    yarn build:css
  fi
fi

log "Entrypoint tasks completed"
exec "$@" 