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
      depths = []
      names = []

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
        # build full path (no trailing slash yet)
        path = stack.map { |c| c.chomp("/") }.join("/")
        depths << depth
        names << name
        items << path
      end

      # Second pass: infer directories by depth
      items.each_with_index.map do |path, i|
        is_dir = directory?(names[i], i, depths)
        is_dir ? (path.end_with?("/") ? path : "#{path}/") : path
      end

    private

      def directory?(name, index, depths)
        name.end_with?("/") || (index < depths.size - 1 && depths[index + 1] > depths[index])
      end
  end
end