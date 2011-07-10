require 'date'

Gem::Specification.new do |s|
  s.name              = 'coffee-views'
  s.version           = '0.1.1'
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
  
  s.add_runtime_dependency('coffee-script')
  s.add_runtime_dependency('actionpack')
  
  s.add_development_dependency("rspec", ["~> 2.6"])  

end