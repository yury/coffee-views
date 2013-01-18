require File.dirname(__FILE__) + '/lib/coffee_views/version'
require 'date'

Gem::Specification.new do |s|
  s.name              = 'coffee-views'
  s.version           = CoffeeViews::VERSION
  s.date              = Date.today.to_s
  s.authors           = ['Yury Korolev']
  s.email             = 'yury.korolev@gmail.com'
  s.homepage          = "http://github.com/yury/coffee-views"
  s.summary           = "CoffeeScript views in rails 3"
  s.description       = "Allows you to create .js.coffee views"
  s.extra_rdoc_files  = %w(README.md)
  s.rdoc_options      = %w(--charset=UTF-8)

  s.files             = `git ls-files`.split("\n")
  s.require_path      = 'lib'
  
  s.add_dependency "rails", ">= 3.2.0"  
  s.add_dependency "coffee-rails"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.6"
  s.add_development_dependency "sass-rails"
  s.add_development_dependency "coffee-rails"
  s.add_development_dependency "uglifier"
  s.add_development_dependency "slim"

end