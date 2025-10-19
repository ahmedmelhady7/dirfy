# frozen_string_literal: true
require "optparse"
require_relative "version"
require_relative "parser"
require_relative "io"

module Dirfy
  # Command-line interface
  class CLI
    def self.start(argv = ARGV)
      options = {
        dry_run: false,
        verbose: false,
        indent: 4,
        prefix: ""
      }

      parser = OptionParser.new do |opts|
        opts.banner = "Usage: dirfy [options] [treefile]"

        opts.on("-d", "--dry-run", "Preview only; no files/dirs created") do
          options[:dry_run] = true
        end

        opts.on("-v", "--verbose", "Log each action") do
          options[:verbose] = true
        end

        opts.on("-iN", "--indent=N", Integer, "Spaces per level (default 4)") do |n|
          options[:indent] = n
        end

        opts.on("-pDIR", "--prefix=DIR", "Prepend DIR/ to every path") do |dir|
          options[:prefix] = dir.chomp("/") + "/"
        end

        opts.on("-V", "--version", "Show version") do
          puts "dirfy #{Dirfy::VERSION}"
          exit
        end

        opts.on("-h", "--help", "Show this help") do
          puts opts
          exit
        end
      end

      parser.parse!(argv)

      lines =
        if argv[0] && File.file?(argv[0])
          File.readlines(argv[0]).map(&:chomp)
        else
          STDIN.read.lines.map(&:chomp)
        end

      items = Parser.new(indent: options[:indent]).parse(lines)
      items.map! { |p| options[:prefix] + p }

      puts "🔍 Detected #{items.size} items to create."
      unless options[:dry_run]
        print "Proceed? (y/N) "
        answer = STDIN.gets.to_s.strip.downcase
        exit(1) unless %w[y yes].include?(answer)
      end

      IO.new(dry_run: options[:dry_run], verbose: options[:verbose]).create(items)
    end
  end
end