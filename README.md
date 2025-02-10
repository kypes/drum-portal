# 🥁 Drum Portal

[![Rails](https://img.shields.io/badge/Rails-8.0.1-red.svg)](https://rubyonrails.org/)
[![Ruby](https://img.shields.io/badge/Ruby-3.2.2-red.svg)](https://www.ruby-lang.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue.svg)](https://www.postgresql.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-3.4.1-blue.svg)](https://tailwindcss.com/)
[![Hotwire](https://img.shields.io/badge/Hotwire-Turbo%20%2B%20Stimulus-purple.svg)](https://hotwired.dev/)
[![Docker](https://img.shields.io/badge/Docker-🐳-blue.svg)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> A modern web application for managing drum lessons between teachers and students, built with Ruby on Rails 8, Hotwire (Turbo + Stimulus), and Tailwind CSS.

## ✨ Features

### 👥 User Management

- **Role-based Access Control**
  - Teacher role for creating and managing lessons
  - Student role for accessing assigned lessons
- **Authentication** via Devise 4.9
- **Authorization** using Pundit 2.4

### 📚 Lesson System

- **Rich Content Support**
  - Markdown formatting with Redcarpet 3.6
  - Syntax highlighting with Rouge
  - HTML sanitization for security
- **YouTube Integration**
  - Embed video content in lessons
- **Real-time Interactions**
  - Live comments and discussions
  - Instant updates via Hotwire

### 🎨 Modern UI/UX

- **Responsive Design** with Tailwind CSS 3.4
- **Real-time Updates** using Turbo Streams
- **Interactive Elements** with Stimulus controllers
- **Accessible Components** following best practices

### ⚡ Technical Features

- **Background Processing** with Sidekiq 7.0
- **Real-time Communication** via Action Cable
- **Caching** strategies for performance
- **API Endpoints** for markdown preview
- **Security** features and best practices

## 🚀 Getting Started

### Prerequisites

- Docker & Docker Compose
- Git
- Node.js >= 20.0.0
- Ruby 3.2.2
- Bundler 2.4.10

### Development Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/drum-portal.git
   cd drum-portal
   ```

2. **Environment Configuration**

   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Build and Start Services**

   ```bash
   docker-compose up --build
   ```

4. **Database Setup**

   ```bash
   docker-compose exec web rails db:setup
   ```

5. **Access the Application**
   - Visit: http://localhost:8080
   - Default test accounts will be created from seeds.rb

### Development Tools

```bash
# Start the development server
./bin/dev

# Run tests
bundle exec rspec

# Run security checks
bundle exec brakeman

# Check code style
bundle exec rubocop

# Watch CSS changes
yarn watch:css
```

## 🏗️ Project Structure

```
app/
├── assets/          # CSS and image assets
├── controllers/     # Application controllers
├── javascript/      # Stimulus controllers
├── models/         # ActiveRecord models
├── policies/       # Pundit authorization policies
└── views/          # View templates and partials

config/             # Application configuration
├── environments/   # Environment-specific settings
├── initializers/   # Rails initializers
└── locales/       # I18n translations

db/                 # Database configuration
├── migrate/        # Database migrations
└── seeds.rb       # Seed data

spec/              # Test files
├── factories/     # FactoryBot definitions
├── models/        # Model specs
└── system/        # System/integration tests
```

## 🧪 Testing

We use RSpec for testing, along with:

- FactoryBot for test data
- Capybara for system tests
- SimpleCov for test coverage
- Shoulda Matchers for common Rails patterns

Run the test suite:

```bash
bundle exec rspec
```

## 📦 Deployment

### Docker Production Build

1. **Build the Production Image**

   ```bash
   docker build -t drum-portal:prod .
   ```

2. **Required Environment Variables**
   - `DATABASE_URL` - PostgreSQL connection URL
   - `REDIS_URL` - Redis connection URL
   - `RAILS_MASTER_KEY` - Rails master key
   - `RAILS_ENV=production`
   - `RAILS_SERVE_STATIC_FILES=true`
   - `APP_HOST` - Application host
   - `SMTP_*` - SMTP configuration

## 🛠️ Technology Stack

- **Backend**

  - Ruby 3.2.2
  - Rails 8.0.1
  - PostgreSQL 15
  - Redis 7
  - Sidekiq 7.3

- **Frontend**

  - Hotwire (Turbo 8.0 + Stimulus 3.2)
  - Tailwind CSS 3.4.1
  - Import Maps
  - Yarn 1.22.19

- **Testing & Quality**
  - RSpec 7.1
  - Brakeman
  - RuboCop Rails Omakase
  - SimpleCov

## 🤝 Contributing

Please read our [Contributing Guidelines](CONTRIBUTING.md) and [Security Policy](SECURITY.md) before submitting pull requests.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Ruby on Rails](https://rubyonrails.org/)
- [Hotwire](https://hotwired.dev/)
- [Tailwind CSS](https://tailwindcss.com/)
- [Devise](https://github.com/heartcombo/devise)
- [Pundit](https://github.com/varvet/pundit)
