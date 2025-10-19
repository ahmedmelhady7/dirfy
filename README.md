# Dirfy

[![Build Status](https://github.com/ahmedmelhady7/dirfy/actions/workflows/ruby.yml/badge.svg)](https://github.com/ahmedmelhady7/dirfy/actions)  
[![Gem Version](https://img.shields.io/gem/v/dirfy.svg)](https://rubygems.org/gems/dirfy)  
[![License](https://img.shields.io/github/license/ahmedmelhady7/dirfy.svg)](LICENSE)  
[![Ruby ≥2.7](https://img.shields.io/badge/ruby-%3E%3D2.7-blue.svg)](https://www.ruby-lang.org/)  
[![Issues](https://img.shields.io/github/issues/ahmedmelhady7/dirfy.svg)](https://github.com/ahmedmelhady7/dirfy/issues)  

> **Instantly scaffold directory & file structures from any ASCII/Unicode “tree” diagram** 🚀

---

## 📋 Problem Statement

Modern AI code generators (ChatGPT, Copilot, etc.) excel at producing code snippets—but often describe project layouts as ASCII or Unicode “tree” diagrams. Manually translating those diagrams into a real folder/file structure is:

- **Time-consuming & error-prone** when projects are large or deeply nested  
- **Tedious** to type out dozens or hundreds of `mkdir -p` / `touch` commands  
- **Prone to typos** and forgotten directories  

**Dirfy** automates the entire process: feed it any tree diagram (text or file), and it creates the exact structure—no matter how big—in seconds.

---

## ✨ Features

- **Parse ASCII & Unicode** tree diagrams  
- **Dry-run mode** (`-d`, `--dry-run`) to preview changes without writing  
- **Verbose logging** (`-v`, `--verbose`) for full action reports  
- **Custom indent** support (`-i N`, `--indent=N`) for non-standard tree outputs  
- **Path prefixing** (`-p DIR/`, `--prefix=DIR/`) to scaffold under any base folder  
- **Live progress bar** and clear success/failure summary  
- **Zero external dependencies** (pure Ruby ≥ 2.7)

---

## 🚀 Installation

```bash
# via RubyGems
gem install dirfy

# or from source
git clone https://github.com/ahmedmelhady7/dirfy.git
cd dirfy
bundle install
rake install
````

---

## 💡 Usage

### From a file

```bash
dirfy path/to/tree.txt
```

### Via pipe

```bash
cat tree.txt | dirfy
```

### Common Options

| Flag                   | Description                                        |
| ---------------------- | -------------------------------------------------- |
| `-d`, `--dry-run`      | Preview actions without creating files/directories |
| `-v`, `--verbose`      | Show each create/skip/fail action                  |
| `-i N`, `--indent=N`   | Set spaces per tree level (default: `4`)           |
| `-p DIR/`, `--prefix=` | Prepend `DIR/` to every generated path             |
| `-h`, `--help`         | Display help and exit                              |

---

## 🛠️ Examples

Given a file `myapp_tree.txt`:

```text
my_app/
├── lib/
│   └── my_app.rb
├── spec/
│   └── my_app_spec.rb
└── README.md
```

Run:

```bash
dirfy -d -v myapp_tree.txt
```

Output (dry-run):

```
🔍 Detected 4 items to create.
DRY-RUN Dir:   my_app/
DRY-RUN Dir:   my_app/lib/
DRY-RUN File:  my_app/lib/my_app.rb
DRY-RUN Dir:   my_app/spec/
DRY-RUN File:  my_app/spec/my_app_spec.rb
DRY-RUN File:  my_app/README.md
```

Remove `-d` to actually scaffold.

---

## 🤝 Contributing

We ❤️ pull-requests, issues, code-reviews, and — most importantly — your ideas to make **dirfy** even better.

1. Read our [CONTRIBUTING.md](./CONTRIBUTING.md) for setup instructions, code style, and the PR process.
2. Fork the repo, branch off `main`, and open a PR.
3. Run tests locally:

   ```bash
   bundle install
   bundle exec rake
   ```
4. Ensure your code follows our style (via `rake lint`) and has adequate test coverage.
5. Celebrate 🎉 — once your PR is merged, add yourself to `AUTHORS.md`!

Happy scaffolding! 🚀

---

## � Release Process

This section documents the release process for maintainers.

### Prerequisites

- Push access to the repository
- RubyGems account with push access to the `dirfy` gem
- 2FA enabled on RubyGems account

### Release Steps

1. **Run tests and ensure clean state**
   ```bash
   bundle exec rake
   git status  # should be clean
   ```

2. **Update version**
   ```bash
   # Edit lib/dirfy/version.rb
   vim lib/dirfy/version.rb
   ```

3. **Commit version bump**
   ```bash
   git add lib/dirfy/version.rb Gemfile.lock
   git commit -m "chore: bump version to vX.Y.Z"
   ```

4. **Create and push tag**
   ```bash
   git tag vX.Y.Z
   git push origin main
   git push origin vX.Y.Z
   ```

5. **Build and publish gem**
   ```bash
   rake build
   gem push pkg/dirfy-X.Y.Z.gem
   # Follow 2FA authentication flow
   ```

6. **Create GitHub release**
   ```bash
   gh release create vX.Y.Z pkg/dirfy-X.Y.Z.gem \
     --title "vX.Y.Z" \
     --notes "Release notes here"
   ```

### Automated Release (Helper Script)

Use the provided release script for semi-automated releases:

```bash
./scripts/release.sh patch  # for patch version (0.0.X)
./scripts/release.sh minor  # for minor version (0.X.0)  
./scripts/release.sh major  # for major version (X.0.0)
```

### Troubleshooting

- **2FA Authentication**: RubyGems requires 2FA. Use WebAuthn or `--otp` flag
- **Workflow scope**: GitHub token needs `workflow` scope to modify Actions
- **Permission denied**: Ensure you have push access to both repo and RubyGems

---

## �📝 License

MIT © [Ahmed Elhady](https://github.com/ahmedmelhady7)

---

> Built with ❤️ to make AI-generated project scaffolding a breeze.

---

## Release steps

This project supports both local and GitHub Actions-based releases. The workflow `/.github/workflows/release.yml` will publish a built gem when a `vX.Y.Z` tag is pushed, but the runner needs a valid `RUBYGEMS_API_KEY` secret and the repository maintainer must ensure the CI token can run workflow jobs that modify releases.

Local release (recommended when you need to provide 2FA interactively):

1. Bump the version in `lib/dirfy/version.rb` (e.g. `0.3.0`).
2. Build the gem locally:

```bash
bundle install
bundle exec rake build
```

3. Create a git tag and push it (this will trigger CI if configured):

```bash
git add -A
git commit -m "Release vX.Y.Z"
git tag vX.Y.Z
git push origin main --follow-tags
```

4. Publish the gem to RubyGems interactively (you may need to complete 2FA):

```bash
gem push pkg/dirfy-X.Y.Z.gem
```

CI-based release (recommended for automated releases):

1. Ensure the repository has the secret `RUBYGEMS_API_KEY` configured in GitHub Settings → Secrets.
2. Ensure the repository's token has appropriate permissions to run workflow jobs that create or update releases (the token needs `workflow` scope to update workflows).
3. Push a tag `vX.Y.Z` to the repo. The `release.yml` workflow will build and push the gem.

Notes and troubleshooting

- If you see an error like `Invalid credentials (401)` during `gem push` in CI, double-check that `RUBYGEMS_API_KEY` is correctly set and that the CI runner writes it to `~/.gem/credentials` before pushing.
- If GitHub rejects pushes that modify workflow files, ensure the token used has `workflow` scope or make the workflow change via the GitHub web UI.
- For local gem publishing, if 2FA is enabled you will be prompted to authenticate in your browser or provide an OTP.
