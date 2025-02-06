# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.2.2
ARG NODE_VERSION=20
ARG BUNDLER_VERSION=2.6.3

FROM registry.docker.com/library/ruby:${RUBY_VERSION}-slim as base

WORKDIR /rails

# Set environment variables
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
    ca-certificates \
    gnupg \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update -qq \
    && apt-get install -y nodejs \
    && npm install -g yarn@$YARN_VERSION \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Create directories and set permissions
RUN mkdir -p tmp/pids storage/tmp app/assets/builds node_modules public/assets && \
    chmod -R 777 tmp storage node_modules public/assets

# Install Ruby dependencies
COPY Gemfile Gemfile.lock ./
RUN gem update --system && \
    gem uninstall bundler --all && \
    gem install bundler -v "${BUNDLER_VERSION}" && \
    bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

# Install Node dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Copy application code
COPY . .

# Build assets
RUN SECRET_KEY_BASE=dummy \
    bundle exec rails assets:precompile && \
    yarn build:css

# Add entrypoint script
COPY bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Start the main process
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
