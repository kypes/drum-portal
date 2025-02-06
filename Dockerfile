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
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Install Node.js and Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get update -qq && apt-get install -y nodejs && \
    npm install -g yarn@$YARN_VERSION && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Create directories and set permissions
RUN mkdir -p tmp/pids storage/tmp app/assets/builds node_modules && \
    chmod -R 777 tmp storage node_modules

# Copy dependency files
COPY package.json yarn.lock ./
RUN yarn install

COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

# Copy application code
COPY . .

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
