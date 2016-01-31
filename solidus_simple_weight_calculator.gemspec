# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'solidus_simple_weight_calculator'
  s.version     = '0.1.0'
  s.summary     = 'A Solidus shipping costs calculator based on total order weight'
  s.required_ruby_version = '>= 1.9.3'

  s.authors    = ['Alessandro Lepore', 'Diego Franciosi']
  s.license   = 'MIT'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'solidus_core', '~> 1.2'

  s.add_development_dependency 'capybara', '~> 2.5.0'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner', '<= 1.0.1'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 3.0'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
