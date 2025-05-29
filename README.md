# Dirfy

[![Build Status](https://github.com/ahmedmelhady7/dirfy/actions/workflows/ruby.yml/badge.svg)](https://github.com/ahmedmelhady7/dirfy/actions)
[![Gem Version](https://badge.fury.io/rb/dirfy.svg)](https://badge.fury.io/rb/dirfy)
[![License](https://img.shields.io/github/license/ahmedmelhady7/dirfy.svg)](https://github.com/ahmedmelhady7/dirfy/blob/main/LICENSE)
[![Ruby ≥2.6](https://img.shields.io/badge/ruby-%3E%3D2.6-blue.svg)](https://www.ruby-lang.org/)
[![Issues](https://img.shields.io/github/issues/ahmedmelhady7/dirfy.svg)](https://github.com/ahmedmelhady7/dirfy/issues)

> **Instantly scaffold directory & file structures from any ASCII/Unicode “tree” diagram** 🚀

---

## 📋 Problem Statement

Modern AI code generators (ChatGPT, Copilot, etc.) excel at producing code snippets—but often describe project layouts as ASCII or Unicode “tree” diagrams. Manually translating those diagrams into a real folder/file structure is:

- **Time-consuming & error-prone** when projects are large or deeply nested
- **Tedious** to type out dozens or hundreds of `mkdir -p` / `touch` commands
- **Prone to typos** and forgotten directories

**Dirfy** solves this by automating the entire process: feed it any `tree` diagram (text or file), and it will parse and create the exact structure—no matter how big—within seconds.

---

## ✨ Features

- **Parse ASCII & Unicode** tree diagrams
- **Dry-run mode** (`-d`) to preview changes without writing
- **Verbose logging** (`-v`) for full action reports
- **Custom indent** support (`-i N`) for non-standard tree outputs
- **Path prefixing** (`-p DIR/`) to scaffold under any base folder
- **Live progress bar** and clear success/failure summary
- **Zero external dependencies** (pure Ruby ≥2.6)

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

| Flag                       | Description                                        |
| -------------------------- | -------------------------------------------------- |
| `-d`, `--dry-run`          | Preview actions without creating files/directories |
| `-v`, `--verbose`          | Show each create/skip/fail action                  |
| `-i N`, `--indent=N`       | Set spaces per tree level (default: `4`)           |
| `-p DIR/`, `--prefix=DIR/` | Prepend `DIR/` to every generated path             |
| `-h`, `--help`             | Display help and exit                              |

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

## 📖 Contributing

1. Fork this repo
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m "Add feature"`)
4. Run tests (`bundle exec rake spec`)
5. Submit a pull request

Please check [CONTRIBUTING.md](CONTRIBUTING.md) for full guidelines.

---

## 📝 License

This project is released under the **MIT License**. See [LICENSE](LICENSE) for details.

---

> Built with ❤️ to make AI-generated project scaffolding a breeze.
