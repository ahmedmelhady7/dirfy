# frozen_string_literal: true

require "spec_helper"
require "open3"
require "tempfile"

RSpec.describe "dirfy CLI" do
  let(:tree) do
    <<~TREE
      demo/
      ├── a.txt
      └── b/
          └── c.txt
    TREE
  end

  it "fails when user aborts" do
    Open3.popen3("ruby bin/dirfy") do |stdin, stdout, stderr, wait|
      stdin.puts(tree)
      stdin.close
      out = stdout.read + stderr.read
      # now expecting 4 items (root + a.txt + b/ + b/c.txt)
      expect(out).to include("Detected 4 items")
      expect(wait.value.exitstatus).to eq(1)
    end
  end

  it "creates files with --dry-run and --verbose" do
    Open3.popen3("ruby bin/dirfy -d -v") do |stdin, stdout, stderr, _|
      stdin.puts(tree)
      stdin.close
      out = stdout.read + stderr.read
      expect(out).to include("DRY-RUN Dir:   demo/")
      expect(out).to include("DRY-RUN File:  demo/a.txt")
      expect(out).to include("DRY-RUN Mkdir: demo/b")
    end
  end

  it "reads from a file argument" do
    file = Tempfile.new("tree")
    file.write(tree)
    file.close
    Open3.popen3("ruby bin/dirfy #{file.path} -d") do |_, stdout, _, _|
      # again expecting 4 items
      expect(stdout.read).to include("Detected 4 items")
    end
  end

  it "shows help when run without arguments in a terminal" do
    # Test by directly calling the CLI.start method with empty ARGV
    # and simulating TTY behavior by stubbing STDIN.tty?
    allow(STDIN).to receive(:tty?).and_return(true)
    
    expect do
      expect { Dirfy::CLI.start([]) }.to raise_error(SystemExit) do |error|
        expect(error.status).to eq(0)
      end
    end.to output(/Usage: dirfy \[options\] \[treefile\]/).to_stdout
  end

  it "shows version with --version flag" do
    Open3.popen3("ruby bin/dirfy --version") do |_, stdout, _, wait|
      output = stdout.read
      expect(output).to match(/^dirfy \d+\.\d+\.\d+$/)
      expect(wait.value.exitstatus).to eq(0)
    end
  end

  it "shows version with -V flag" do
    Open3.popen3("ruby bin/dirfy -V") do |_, stdout, _, wait|
      output = stdout.read
      expect(output).to match(/^dirfy \d+\.\d+\.\d+$/)
      expect(wait.value.exitstatus).to eq(0)
    end
  end
end
