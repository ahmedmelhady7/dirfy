# Contributing to Dirfy

First off, **thank you** for taking the time to contribute! 🎉 Your efforts help make Dirfy better and more robust for everyone.

This guide covers:

- [Contributing to Dirfy](#contributing-to-dirfy)
  - [Getting Started](#getting-started)
  - [Development Workflow](#development-workflow)
  - [Code Style \& Linting](#code-style--linting)
  - [Testing \& Coverage](#testing--coverage)
  - [Submitting a Pull Request](#submitting-a-pull-request)
  - [Issue Reporting](#issue-reporting)
  - [Code of Conduct](#code-of-conduct)

---

## Getting Started

1. **Fork** this repository on GitHub.  
2. **Clone** your fork locally:
   ```bash
   git clone git@github.com:YOUR_USERNAME/dirfy.git
   cd dirfy

3. **Install** dependencies:

   ```bash
   gem install bundler
   bundle install
   ```
4. **Verify** everything works:

   ```bash
   bundle exec rake spec
   ```

---

## Development Workflow

We follow a **feature-branch** workflow:

1. Create a new branch off `main`:

   ```bash
   git checkout main
   git pull origin main
   git checkout -b feature/my-awesome-feature
   ```
2. Write your code, tests, and documentation.
3. Keep your branch up to date:

   ```bash
   git fetch origin
   git rebase origin/main
   ```
4. When ready, **push** your branch:

   ```bash
   git push -u origin feature/my-awesome-feature
   ```

---

## Code Style & Linting

We use [RuboCop](https://github.com/rubocop/rubocop) to enforce style guidelines:

```bash
# Run lint checks
bundle exec rubocop

# Auto-correct simple offenses
bundle exec rubocop -A
```

Please ensure your changes introduce **no** new offenses beyond errors (`E`) or failures (`F`).

---

## Testing & Coverage

* Tests are written with **RSpec**.
* Coverage is measured with **SimpleCov**.
* To run the full test suite:

  ```bash
  bundle exec rake spec
  ```
* Coverage reports appear in the `coverage/` directory. Aim for **≥ 90%** coverage on new code.

---

## Submitting a Pull Request

1. Ensure tests and linting pass locally.
2. Update `CHANGELOG.md` under the “Unreleased” heading:

   ```markdown
   ## [Unreleased]
   ### Added
   - Description of new feature or fix
   ```
3. Bump the version if you’ve added or changed public API (see `lib/dirfy/version.rb`):

   ```bash
   bump 0.2.0
   ```
4. Push your branch and open a PR against the `main` branch.
5. Include a clear description of your changes, any relevant screenshots or logs, and link to related issues.
6. Request a review from a maintainer or team member.

---

## Issue Reporting

When reporting a bug or suggesting a feature, please include:

* A **clear title** and description.
* **Steps to reproduce** the issue, including code snippets if relevant.
* Your **environment** details:

  ```bash
  ruby -v       # Ruby version
  dirfy --version  # Dirfy version
  ```
* Any **error messages** or stack traces.

Use our issue templates:

* [Bug Report](.github/ISSUE_TEMPLATE/bug_report.md)
* [Feature Request](.github/ISSUE_TEMPLATE/feature_request.md)

---

## Code of Conduct

This project adheres to the [Contributor Covenant](https://www.contributor-covenant.org/).
By participating, you are expected to uphold this code. Please see [CODE\_OF\_CONDUCT.md](CODE_OF_CONDUCT.md) for details.

---

Thank you for contributing to **Dirfy**! Your help makes scaffolding easier for everyone. 🚀