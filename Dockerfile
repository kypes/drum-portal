# syntax = docker/dockerfile:1

FROM registry.docker.com/library/ruby:3.2.2-slim as base

WORKDIR /rails

ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_BIN=/usr/local/bundle/bin \
    PATH=/usr/local/bundle/bin:$PATH \
    RAILS_ENV=development \
    NODE_ENV=development \
    YARN_VERSION=1.22.19

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    postgresql-client \
    redis-tools \
    tzdata \
    node-gyp \
    pkg-config \
    python-is-python3 \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get update -qq && apt-get install -y nodejs && \
    npm install -g yarn@$YARN_VERSION && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Create directories for app
RUN mkdir -p tmp/pids tmp/storage app/assets/builds

# Copy dependency files
COPY package.json yarn.lock ./
RUN yarn install

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# Copy application code
COPY . .

# Create storage directory and set permissions
RUN chmod -R 777 tmp/storage

# Build Tailwind CSS
RUN yarn build:css

# Precompile assets
RUN SECRET_KEY_BASE=dummy bundle exec rails assets:precompile

# Add entrypoint script
COPY bin/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Start the main process
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
