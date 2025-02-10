# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.2.2
ARG NODE_VERSION=20
ARG BUNDLER_VERSION=2.4.10

# Base stage for shared dependencies
FROM registry.docker.com/library/ruby:${RUBY_VERSION}-slim as base

# Install common dependencies
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
    ca-certificates \
    gnupg \
    dos2unix \
    openssl \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update -qq \
    && apt-get install -y nodejs \
    && npm install -g yarn@1.22.19 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Set environment variables
ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_BIN=/usr/local/bundle/bin \
    GEM_HOME=/usr/local/bundle \
    PATH=/usr/local/bundle/bin:$PATH \
    RAILS_ENV=development \
    NODE_ENV=development \
    YARN_VERSION=1.22.19 \
    BUNDLE_APP_CONFIG=/usr/local/bundle \
    BUNDLE_HTTPS=true

# Create and set working directory
WORKDIR /rails

# Copy entrypoint script and make it executable
COPY bin/docker-entrypoint.sh /usr/local/bin/
RUN dos2unix /usr/local/bin/docker-entrypoint.sh && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

# Copy Gemfile and install bundler
COPY Gemfile Gemfile.lock ./
RUN gem update --system && \
    gem install bundler -v "${BUNDLER_VERSION}"

# Copy package files and install dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Copy application code
COPY . .

# Create directories and set permissions
RUN mkdir -p tmp/pids storage/tmp app/assets/builds node_modules public/assets && \
    chmod -R 777 tmp storage node_modules public/assets tmp/pids log /usr/local/bundle && \
    chown -R 1000:1000 tmp storage node_modules public/assets tmp/pids log /usr/local/bundle

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Start the main process
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
