# frozen_string_literal: true

# Start SimpleCov for test coverage when COVERAGE=true
if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/vendor/'
    enable_coverage :branch
  end
end

require "bundler/setup"
require "dirfy"