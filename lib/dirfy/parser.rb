# frozen_string_literal: true
require "strscan"

module Dirfy
  # Parses ASCII/Unicode tree diagrams into flat path lists.
  class Parser
    def initialize(indent: 4)
      @indent = indent
    end

    # lines - Array<String>
    # returns Array<String> of relative paths, dirs ending with '/'
    def parse(lines)
      stack = []
      items = []

      lines.each do |raw|
        line = raw.rstrip
        next if line.strip.empty? || line.strip.start_with?("#")

        if line.match?(/[└├]/)
          # replace tree chars with spaces to count indent
          indent_str = line.gsub(/[│├└─]/, " ")
          lead_spaces = indent_str[/\A */].size
          depth = lead_spaces / @indent
          name  = line.split("── ", 2).last
        else
          depth = 0
          name  = line.strip
        end

        stack[depth] = name
        stack = stack[0..depth]

        # build full path
        path = stack.map { |c| c.chomp("/") }.join("/")
        path << "/" if name.end_with?("/")
        items << path
      end

      items
    end
  end
end