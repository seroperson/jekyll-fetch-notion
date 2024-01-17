# frozen_string_literal: true

require_relative "lib/jekyll-fetch-notion/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll-fetch-notion"
  spec.version = JekyllFetchNotion::VERSION
  spec.authors = ["Enrique Arias", "Daniil Sivak"]
  spec.email = ["emoriarty81@gmail.com", "seroperson@gmail.com"]
  spec.summary = "A Jekyll plugin to generate pages from Notion"
  spec.homepage = "https://github.com/seroperson/jekyll-fetch-notion"
  spec.license = "MIT"

  spec.files = Dir["lib/**/*", "README.md"]
  spec.extra_rdoc_files = Dir["README.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "jekyll", ">= 3.7", "< 5.0"
  spec.add_dependency "notion-ruby-client", "~> 1.0"
  spec.add_dependency "notion_to_md", "~> 2.2"

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 6.2"
  spec.add_development_dependency "rubocop-jekyll", "~> 0.12"
  spec.add_development_dependency "simplecov", "~> 0.21"
end
