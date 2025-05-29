# frozen_string_literal: true
require "fileutils"

module Dirfy
  # Creates directories/files with progress bar, dry-run, verbose modes.
  class IO
    def initialize(dry_run: false, verbose: false)
      @dry_run    = dry_run
      @verbose    = verbose
      @dirs       = @files = @skipped = @failed = 0
      @bar_length = 30
    end

    # items - Array<String>
    def create(items)
      total = items.size
      items.each_with_index do |item, idx|
        print_progress(idx + 1, total)
        if item.end_with?("/")
          create_dir(item)
        else
          create_file(item)
        end
      end
      puts
      print_summary
    end

    private

    def create_dir(path)
      if @dry_run
        log "DRY-RUN Dir:   #{path}"
      else
        if Dir.exist?(path)
          log "Skipped dir:  #{path}"
          @skipped += 1
        else
          FileUtils.mkdir_p(path)
          log "Created dir:  #{path}"
          @dirs += 1
        end
      end
    rescue StandardError => e
      warn "Failed dir:   #{path} (#{e.message})"
      @failed += 1
    end

    def create_file(path)
      dir = File.dirname(path)
      unless Dir.exist?(dir)
        if @dry_run
          log "DRY-RUN Mkdir: #{dir}"
        else
          FileUtils.mkdir_p(dir)
        end
      end

      if @dry_run
        log "DRY-RUN File:  #{path}"
      else
        if File.exist?(path)
          log "Skipped file: #{path}"
          @skipped += 1
        else
          FileUtils.touch(path)
          log "Created file: #{path}"
          @files += 1
        end
      end
    rescue StandardError => e
      warn "Failed file:  #{path} (#{e.message})"
      @failed += 1
    end

    def print_progress(current, total)
      pct    = (current * 100.0 / total).floor
      filled = (pct * @bar_length / 100.0).floor
      empty  = @bar_length - filled
      bar    = "█" * filled + " " * empty
      print "\r🤖 [#{bar}] #{pct}%"
    end

    def log(msg)
      puts msg if @verbose || @dry_run
    end

    def warn(msg)
      STDERR.puts "⚠️  #{msg}"
    end

    def print_summary
      puts "Summary → dirs=#{@dirs}, files=#{@files}, skipped=#{@skipped}, failed=#{@failed}"
    end
  end
end