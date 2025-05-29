# frozen_string_literal: true

# Load the version constant so we can reference Dirfy::VERSION
require_relative "lib/dirfy/version"

Gem::Specification.new do |spec|
  spec.name          = "dirfy"
  spec.version       = Dirfy::VERSION
  spec.summary       = "Create directory/file structures from ASCII/Unicode tree diagrams"
  spec.authors       = ["Your Name"]
  spec.email         = ["you@example.com"]
  spec.files         = Dir.glob("lib/**/*.rb") + ["bin/dirfy", "Rakefile", "README.md"]
  spec.executables   = ["dirfy"]
  spec.require_paths = ["lib"]
  spec.homepage      = "https://github.com/ahmedmelhady7/dirfy"
  spec.license       = "MIT"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec"
end
