# frozen_string_literal: true
require "spec_helper"
require "tmpdir"

RSpec.describe Dirfy::IO do
  around do |example|
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) { example.run }
    end
  end

  let(:items) { ["foo/", "foo/bar.txt", "baz.txt"] }

  context "dry-run" do
    it "prints actions but does not create" do
      io = described_class.new(dry_run: true, verbose: false)
      expect { io.create(items) }
        .to output(/DRY-RUN Dir:/).to_stdout
      expect(Dir.exist?("foo")).to be false
      expect(File.exist?("foo/bar.txt")).to be false
    end
  end

  context "actual run" do
    it "creates directories and files" do
      io = described_class.new(dry_run: false, verbose: true)
      output = capture_stdout { io.create(items) }
      expect(output).to match(/Created dir:\s+foo\//)
      expect(output).to match(/Created file:\s+foo\/bar.txt/)
      expect(output).to match(/Created file:\s+baz.txt/)
      expect(Dir.exist?("foo")).to be true
      expect(File.exist?("foo/bar.txt")).to be true
      expect(File.exist?("baz.txt")).to be true
    end

    it "skips existing items" do
      FileUtils.mkdir_p("foo")
      FileUtils.touch("foo/bar.txt")
      io = described_class.new(dry_run: false, verbose: true)
      output = capture_stdout { io.create(items) }
      expect(output).to match(/Skipped dir:\s+foo\//)
      expect(output).to match(/Skipped file:\s+foo\/bar.txt/)
    end
  end
end

# helper to capture STDOUT in specs
def capture_stdout(&block)
  original = $stdout
  $stdout = StringIO.new
  block.call
  $stdout.string
ensure
  $stdout = original
end