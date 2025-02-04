# 🥁 Drum Teacher Student Portal

[![Rails](https://img.shields.io/badge/Rails-7.1.2-red.svg)](https://rubyonrails.org/)
[![Ruby](https://img.shields.io/badge/Ruby-3.2.2-red.svg)](https://www.ruby-lang.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue.svg)](https://www.postgresql.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-3.4.1-blue.svg)](https://tailwindcss.com/)
[![Hotwire](https://img.shields.io/badge/Hotwire-Turbo%20%2B%20Stimulus-purple.svg)](https://hotwired.dev/)
[![Docker](https://img.shields.io/badge/Docker-🐳-blue.svg)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> A modern web application for managing drum lessons between teachers and students, built with Ruby on Rails 7, Hotwire (Turbo + Stimulus), and Tailwind CSS.

## ✨ Features

### 👥 User Management

- **Role-based Access Control**
  - Teacher role for creating and managing lessons
  - Student role for accessing assigned lessons
- **Authentication** via Devise
- **Authorization** using Pundit policies

### 📚 Lesson System

- **Rich Content Support**
  - Markdown formatting with Redcarpet
  - Syntax highlighting with Rouge
  - HTML sanitization for security
- **YouTube Integration**
  - Embed video content in lessons
- **Real-time Interactions**
  - Live comments and discussions
  - Instant updates via Hotwire

### 🎨 Modern UI/UX

- **Responsive Design** with Tailwind CSS
- **Real-time Updates** using Turbo Streams
- **Interactive Elements** with Stimulus controllers
- **Accessible Components** following best practices

### ⚡ Technical Features

- **Background Processing** with Sidekiq
- **Real-time Communication** via Action Cable
- **Caching** strategies for performance
- **API Endpoints** for markdown preview
- **Security** features and best practices

## 🚀 Getting Started

### Prerequisites

- Docker & Docker Compose
- Git
- Node.js >=16.20.2
- Ruby 3.2.2

### Development Setup

1. **Clone the Repository**

   ```bash
   git clone <repository-url>
   cd rubyPortal
   ```

2. **Environment Configuration**

   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Build and Start Services**

   ```bash
   # For Windows PowerShell
   ./docker-compose.ps1 up

   # For other systems
   docker-compose up --build
   ```

4. **Database Setup**

   ```bash
   docker-compose exec web rails db:setup
   ```

5. **Access the Application**
   - Visit: http://localhost:3000
   - Default Accounts:
     - Teacher: teacher@example.com (password: password123)
     - Student: student@example.com (password: password123)

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
├── controllers/
│   ├── api/        # API endpoints
│   ├── teacher/    # Teacher-specific controllers
│   └── student/    # Student-specific controllers
├── javascript/
│   └── controllers/ # Stimulus controllers
├── jobs/           # Background jobs
├── mailers/        # Email templates
├── models/         # ActiveRecord models
├── policies/       # Pundit authorization policies
└── views/
    ├── layouts/    # Application layouts
    ├── shared/     # Shared partials
    ├── teacher/    # Teacher views
    └── student/    # Student views

config/             # Application configuration
├── environments/   # Environment-specific settings
├── initializers/   # Rails initializers
└── locales/       # I18n translations

db/                 # Database configuration and migrations
├── migrate/       # Database migrations
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

2. **Configure Production Environment**

   - Set up production database
   - Configure Redis for Action Cable
   - Set up email delivery
   - Configure asset storage

3. **Environment Variables**
   Required variables:
   - `DATABASE_URL` - PostgreSQL connection URL
   - `REDIS_URL` - Redis connection URL
   - `RAILS_MASTER_KEY` - Rails master key for credentials
   - `RAILS_ENV=production` - Set environment to production
   - `RAILS_SERVE_STATIC_FILES=true` - Enable serving static files
   - `APP_HOST` - Application host for mailer configuration
   - `SMTP_ADDRESS` - SMTP server address
   - `SMTP_PORT` - SMTP port (defaults to 587)
   - `SMTP_DOMAIN` - SMTP domain
   - `SMTP_USERNAME` - SMTP username
   - `SMTP_PASSWORD` - SMTP password

## 🛠️ Technology Stack

- **Backend**

  - Ruby 3.2.2
  - Rails 7.1.2
  - PostgreSQL 15
  - Redis 7
  - Sidekiq 7.0

- **Frontend**

  - Hotwire (Turbo 8.0 + Stimulus 3.2)
  - Tailwind CSS 3.4.1
  - Import Maps for JavaScript
  - Yarn for package management

- **Testing & Quality**
  - RSpec
  - Brakeman
  - RuboCop
  - SimpleCov

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. Commit your changes
   ```bash
   git commit -m 'Add amazing feature'
   ```
4. Push to the branch
   ```bash
   git push origin feature/amazing-feature
   ```
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Ruby on Rails](https://rubyonrails.org/)
- [Hotwire](https://hotwired.dev/)
- [Tailwind CSS](https://tailwindcss.com/)
- [Devise](https://github.com/heartcombo/devise)
- [Pundit](https://github.com/varvet/pundit)
- [Redcarpet](https://github.com/vmg/redcarpet)
