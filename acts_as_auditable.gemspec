# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "acts_as_auditable/version"

Gem::Specification.new do |s|
  s.name        = "acts_as_auditable"
  s.version     = ActsAsAuditable::VERSION
  s.authors     = ["Nicolas Rodriguez"]
  s.email       = ["nrodriguez@jbox-web.com"]
  s.homepage    = "http://github.com/jbox-web/acts_as_auditable"
  s.summary     = "Auditable Rails Engine."
  s.description = "Audit ActiveRecord models."
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0", ">= 4.0.0"
  s.add_dependency "request_store"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec",       "~> 3.0", ">= 3.0.0"
  s.add_development_dependency "rspec-rails", "~> 3.0", ">= 3.0.2"
  s.add_development_dependency "rspec-collection_matchers", "~> 1.0", ">= 1.0.0"

  s.add_development_dependency "shoulda",          "~> 3.5", ">= 3.5.0"
  s.add_development_dependency "shoulda-matchers", "~> 2.7", ">= 2.7.0"
  s.add_development_dependency "shoulda-context",  "~> 1.2", ">= 1.2.1"

  s.add_development_dependency "factory_girl",       "~> 4.4", ">= 4.4.0"
  s.add_development_dependency "factory_girl_rails", "~> 4.4", ">= 4.4.1"
  s.add_development_dependency "faker",              "~> 1.4", ">= 1.4.2"
  s.add_development_dependency "database_cleaner",   "~> 1.3", ">= 1.3.0"

  s.add_development_dependency "capybara", "~> 2.4", ">= 2.4.3"

  s.add_development_dependency "simplecov", "~> 0.9", ">= 0.9.1"
  s.add_development_dependency "simplecov-rcov", "~> 0.2", ">= 0.2.3"
end
