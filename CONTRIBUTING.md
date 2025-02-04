# Contributing to Drum Portal

Thank you for your interest in contributing to Drum Portal! This document provides guidelines and instructions for contributing.

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

- Use a clear and descriptive title
- Describe the exact steps to reproduce the problem
- Provide specific examples to demonstrate the steps
- Describe the behavior you observed after following the steps
- Explain which behavior you expected to see instead and why
- Include screenshots if possible

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- Use a clear and descriptive title
- Provide a step-by-step description of the suggested enhancement
- Provide specific examples to demonstrate the steps
- Describe the current behavior and explain which behavior you expected to see instead
- Explain why this enhancement would be useful

### Pull Requests

- Fill in the required template
- Do not include issue numbers in the PR title
- Follow the Ruby styleguide
- Include thoughtfully-worded, well-structured tests
- Document new code
- End all files with a newline

## Development Process

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Run the tests to ensure they pass
4. Make your changes
5. Add or update tests as needed
6. Run the test suite to ensure everything still passes
7. Commit your changes (`git commit -m 'Add some amazing feature'`)
8. Push to the branch (`git push origin feature/amazing-feature`)
9. Open a Pull Request

### Development Setup

```bash
# Clone your fork
git clone https://github.com/your-username/drum-portal.git

# Add the main repository as a remote
git remote add upstream https://github.com/main-username/drum-portal.git

# Create your feature branch
git checkout -b feature/amazing-feature

# Start the development environment
docker-compose up
```

### Running Tests

```bash
# Run the full test suite
docker-compose exec web rspec

# Run specific tests
docker-compose exec web rspec spec/path/to/test_spec.rb

# Run the linter
docker-compose exec web rubocop
```

## Style Guides

### Git Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line

### Ruby Style Guide

- Follow the [Ruby Style Guide](https://github.com/rubocop/ruby-style-guide)
- Run RuboCop before committing
- Keep methods small and focused
- Use meaningful variable names

### Rails Style Guide

- Follow the [Rails Style Guide](https://github.com/rubocop/rails-style-guide)
- Use RESTful routes
- Keep controllers skinny, models fat
- Use service objects for complex business logic

### Documentation Style Guide

- Use [Markdown](https://guides.github.com/features/mastering-markdown/)
- Reference methods and classes in backticks: \`Class#method\`
- Use code blocks for examples
- Keep line length to 80 characters or less

## Additional Notes

### Issue and Pull Request Labels

- `bug` - Something isn't working
- `enhancement` - New feature or request
- `documentation` - Improvements or additions to documentation
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention is needed
- `invalid` - Something's wrong
- `question` - Further information is requested
- `wontfix` - This will not be worked on
