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

## 📝 License

MIT © [Ahmed Elhady](https://github.com/ahmedmelhady7)

---

> Built with ❤️ to make AI-generated project scaffolding a breeze.