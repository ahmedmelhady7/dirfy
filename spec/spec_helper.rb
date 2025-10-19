# frozen_string_literal: true

# Start SimpleCov for test coverage (if available and not in CI for pull_request)
if ENV['COVERAGE'] == 'true' || (ENV['CI'] && ENV['GITHUB_EVENT_NAME'] != 'pull_request')
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/vendor/'
    enable_coverage :branch
  end
end

require "bundler/setup"
require "dirfy"