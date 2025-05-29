# frozen_string_literal: true
require "spec_helper"

RSpec.describe Dirfy::Parser do
  let(:parser) { described_class.new(indent: 4) }

  it "parses a simple root-only tree" do
    lines = ["root/"]
    expect(parser.parse(lines)).to eq(["root/"])
  end

  it "parses mixed files and dirs" do
    lines = [
      "lms_app/",
      "├── app/",
      "│   ├── domain/",
      "│   │   └── course.rb",
      "│   └── web/",
      "│       └── index.rb",
      "└── config/",
      "    └── routes.rb"
    ]
    expect(parser.parse(lines)).to eq([
      "lms_app/",
      "lms_app/app/",
      "lms_app/app/domain/",
      "lms_app/app/domain/course.rb",
      "lms_app/app/web/",
      "lms_app/app/web/index.rb",
      "lms_app/config/",
      "lms_app/config/routes.rb"
    ])
  end

  it "ignores comments and blank lines" do
    lines = ["# comment", "", "foo/"]
    expect(parser.parse(lines)).to eq(["foo/"])
  end

  it "supports custom indent width" do
    p2 = described_class.new(indent: 2)
    lines = ["root/", "├─ a.txt", "└─ b.txt"]
    expect(p2.parse(lines)).to eq(["root/", "root/a.txt", "root/b.txt"])
  end
end