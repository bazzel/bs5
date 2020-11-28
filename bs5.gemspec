# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'bs5/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'bs5'
  spec.version     = Bs5::VERSION
  spec.authors     = ['Patrick Baselier']
  spec.email       = ['patrick.baselier@gmail.com']
  spec.homepage    = 'https://github.com/bazzel/bs5'
  spec.summary     = 'Bootstrap 5'
  spec.description = '[WIP] Rails engine to include Bootstrap 5.'
  spec.license     = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.required_ruby_version = '>= 2.6.6'

  spec.add_dependency 'nokogiri', '~> 1.10.10'
  spec.add_dependency 'rails', '~> 6.0.3', '>= 6.0.3.4'
  spec.add_dependency 'rouge', '~> 3.25.0'
  spec.add_dependency 'rubocop-rails', '~> 2.8'
  spec.add_dependency 'view_component', '~> 2.22.0'

  spec.add_development_dependency 'capybara', '~> 3.33'
  spec.add_development_dependency 'rspec-rails', '~> 4.0.1'
  spec.add_development_dependency 'sqlite3'
end
