## Dirfy — Copilot instructions for code changes
## Dirfy — Copilot instructions for code changes

Quick, focused notes to help an AI coding agent be productive in this Ruby gem.

- Project type: small Ruby gem (Ruby ≥ 2.7). See `Gemfile`, `dirfy.gemspec` and `Rakefile`.
- Entrypoints:
  - CLI: `bin/dirfy` -> Dirfy::CLI (`lib/dirfy/cli.rb`).
  - Library surface: `lib/dirfy.rb` which requires `parser`, `io`, and `cli`.

- Running tests and common commands
  - Install dependencies: `bundle install` (uses rubygems and the gemspec).
  - Run tests: `bundle exec rake` (Rakefile defines `RSpec::Core::RakeTask`).
  - Run CLI locally: `ruby bin/dirfy [treefile]` or pipe input: `cat tree.txt | ruby bin/dirfy`.

- Important runtime behaviors to preserve
  - CLI prompts for confirmation unless `--dry-run` is used. The code calls `STDIN.gets` and exits with status 1 on non-yes answers. Tests assert this behavior.
  - `--dry-run` and `--verbose` cause Dirfy::IO to print explicit DRY-RUN messages (see `lib/dirfy/io.rb`). Tests depend on exact message substrings like `DRY-RUN Dir:` and `DRY-RUN File:`.
  - `--prefix` appends a directory prefix to every generated path in Dirfy::CLI (it ensures the prefix ends with a single `/`).

-- Parsing rules (keep these semantics when editing Parser)
  - The Parser class parse method accepts an array of lines and returns flattened relative paths.
  - A path ending with `/` is considered a directory. Indentation depth (based on `indent` option, default 4) is used to infer directories when subsequent lines are deeper.
  - Unicode tree characters (├ └ │ ─) are handled by replacing them with spaces for indent counting. Single-dash ASCII (├─) is preserved in the current implementation and tests (see `spec/dirfy/parser_spec.rb`).

-- IO behavior and side-effects
  - The Dirfy IO create method prints a progress bar to stdout and logs created/skipped/failed items.
  - Warnings and failures are printed to STDERR prefixed with a ⚠️ emoji (see the warn method in Dirfy IO).
  - Specs run IO code inside a temporary directory (see `spec/dirfy/io_spec.rb`); follow the same pattern when writing integration tests to avoid touching the repo working tree.

- Tests and fixtures
  - Specs use `capture_stdout` helper in `spec/dirfy/io_spec.rb` to assert verbose output. Use that helper or similar when asserting printed output.
  - CLI specs use `Open3.popen3` and `Tempfile` to simulate stdin/file args. Follow that pattern for functional tests.

- Development & packaging notes
  - Packaging and install is via `rake install` (uses `bundler/gem_tasks`).
  - Keep the public API small: authors intended a thin CLI + Parser + IO separation. Avoid introducing global state or heavy runtime dependencies.

- Small, actionable patterns/examples
  - To create an automated test asserting dry-run output: call Dirfy::IO.new(dry_run: true, verbose: false).create(items) and capture stdout.
  - To test CLI file-arg behavior: `Open3.popen3("ruby bin/dirfy <treefile> -d")` and assert `Detected N items` in stdout.

If anything about the project setup or expected CLI behavior is unclear, tell me which area to expand (tests, packaging, parser edge-cases) and I will update these instructions.
