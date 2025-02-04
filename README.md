# 🥁 Drum Teacher Student Portal

[![Rails](https://img.shields.io/badge/Rails-7.1.5-red.svg)](https://rubyonrails.org/)
[![Ruby](https://img.shields.io/badge/Ruby-3.2.2-red.svg)](https://www.ruby-lang.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue.svg)](https://www.postgresql.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-3.4-blue.svg)](https://tailwindcss.com/)
[![Docker](https://img.shields.io/badge/Docker-🐳-blue.svg)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> A modern web application for managing drum lessons between teachers and students, built with Ruby on Rails 7, Hotwire, and Tailwind CSS.

![Drum Portal Screenshot](docs/screenshot.png)

## ✨ Features

- 👥 **User Roles**
  - Teachers can create and manage lessons
  - Students can view assigned lessons and track progress
- 📚 **Lesson Management**
  - Rich Markdown content support
  - YouTube video integration
  - Real-time comments and discussions
- 🏆 **Gamification**
  - Points system for lesson completion
  - Progress tracking and achievements
- ⚡ **Modern Tech Stack**
  - Real-time updates with Hotwire (Turbo + Stimulus)
  - Responsive design with Tailwind CSS
  - Background jobs with Sidekiq
  - Real-time notifications with Action Cable

## 🚀 Quick Start

### Prerequisites

- Docker & Docker Compose
- Git

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/drum-portal.git
   cd drum-portal
   ```

2. Set up environment variables:

   ```bash
   cp .env.example .env
   ```

3. Build and start the containers:

   ```bash
   docker-compose up --build
   ```

4. Setup the database:
   ```bash
   docker-compose exec web rails db:setup
   ```

Visit http://localhost:3000 and log in with:

- 👨‍🏫 Teacher: teacher@example.com (password: password123)
- 👨‍🎓 Student: student@example.com (password: password123)

## 🛠️ Development

### Useful Commands

```bash
# Access Rails console
docker-compose exec web rails c

# Run tests
docker-compose exec web rspec

# Run linter
docker-compose exec web rubocop

# View logs
docker-compose logs -f web
```

### Architecture

```
app/
├── controllers/    # Request handling
├── models/        # Business logic & data relations
├── views/         # UI templates
├── javascript/    # Stimulus controllers
├── components/    # View components
└── services/      # Complex business operations
```

## 🧪 Testing

We use RSpec for testing. Run the full suite:

```bash
docker-compose exec web rspec
```

## 📦 Deployment

1. Build production image:

   ```bash
   docker build -t drum-portal:prod -f Dockerfile.prod .
   ```

2. Set production environment variables:

   ```bash
   cp .env.production.example .env.production
   ```

3. Deploy using your preferred platform (Heroku, AWS, etc.)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit changes (`git commit -am 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Ruby on Rails](https://rubyonrails.org/)
- [Hotwire](https://hotwired.dev/)
- [Tailwind CSS](https://tailwindcss.com/)
- [PostgreSQL](https://www.postgresql.org/)
- [Redis](https://redis.io/)
