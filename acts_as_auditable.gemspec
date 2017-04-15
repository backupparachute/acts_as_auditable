# -*- encoding: utf-8 -*-
# stub: acts_as_auditable 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "acts_as_auditable"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nicolas Rodriguez"]
  s.date = "2017-04-01"
  s.description = "Audit ActiveRecord models."
  s.email = ["nrodriguez@jbox-web.com"]
  s.files = ["LICENSE", "README.md", "Rakefile", "app/models", "app/models/acts_as_auditable", "app/models/acts_as_auditable/audit.rb", "config/database.yml", "db/migrate", "db/migrate/20131029200927_create_acts_as_auditable_table.rb", "lib/acts_as_auditable", "lib/acts_as_auditable.rb", "lib/acts_as_auditable/auditor.rb", "lib/acts_as_auditable/auditor_behavior.rb", "lib/acts_as_auditable/auditor_request.rb", "lib/acts_as_auditable/engine.rb", "lib/acts_as_auditable/version.rb", "spec/controllers", "spec/controllers/audits_controller_spec.rb", "spec/dummy", "spec/dummy/README.rdoc", "spec/dummy/Rakefile", "spec/dummy/app", "spec/dummy/app/controllers", "spec/dummy/app/controllers/application_controller.rb", "spec/dummy/app/models", "spec/dummy/app/models/comment.rb", "spec/dummy/app/models/recipe.rb", "spec/dummy/app/models/user.rb", "spec/dummy/bin", "spec/dummy/bin/bundle", "spec/dummy/bin/rails", "spec/dummy/bin/rake", "spec/dummy/config", "spec/dummy/config.ru", "spec/dummy/config/application.rb", "spec/dummy/config/boot.rb", "spec/dummy/config/database.yml", "spec/dummy/config/environment.rb", "spec/dummy/config/environments", "spec/dummy/config/environments/development.rb", "spec/dummy/config/environments/production.rb", "spec/dummy/config/environments/test.rb", "spec/dummy/config/initializers", "spec/dummy/config/initializers/backtrace_silencers.rb", "spec/dummy/config/initializers/filter_parameter_logging.rb", "spec/dummy/config/initializers/inflections.rb", "spec/dummy/config/initializers/mime_types.rb", "spec/dummy/config/initializers/secret_token.rb", "spec/dummy/config/initializers/session_store.rb", "spec/dummy/config/initializers/wrap_parameters.rb", "spec/dummy/config/locales", "spec/dummy/config/locales/en.yml", "spec/dummy/config/routes.rb", "spec/dummy/db", "spec/dummy/db/migrate", "spec/dummy/db/migrate/20131029211126_create_users.rb", "spec/dummy/db/migrate/20131030014901_create_recipes.rb", "spec/dummy/db/migrate/20131030014902_create_comments.rb", "spec/dummy/db/schema.rb", "spec/dummy/log", "spec/factories", "spec/factories/audit.rb", "spec/factories/comment.rb", "spec/factories/recipe.rb", "spec/factories/user.rb", "spec/models", "spec/models/acts_as_auditable", "spec/models/acts_as_auditable/audit_spec.rb", "spec/models/models", "spec/models/models/recipe_spec.rb", "spec/rails_helper.rb", "spec/spec_helper.rb"]
  s.homepage = "http://github.com/jbox-web/acts_as_auditable"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Auditable Rails Engine."
  s.test_files = ["spec/controllers", "spec/controllers/audits_controller_spec.rb", "spec/models", "spec/models/acts_as_auditable", "spec/models/acts_as_auditable/audit_spec.rb", "spec/models/models", "spec/models/models/recipe_spec.rb", "spec/spec_helper.rb", "spec/rails_helper.rb", "spec/factories", "spec/factories/user.rb", "spec/factories/audit.rb", "spec/factories/recipe.rb", "spec/factories/comment.rb", "spec/dummy", "spec/dummy/app", "spec/dummy/app/controllers", "spec/dummy/app/controllers/application_controller.rb", "spec/dummy/app/models", "spec/dummy/app/models/user.rb", "spec/dummy/app/models/recipe.rb", "spec/dummy/app/models/comment.rb", "spec/dummy/bin", "spec/dummy/bin/rake", "spec/dummy/bin/rails", "spec/dummy/bin/bundle", "spec/dummy/log", "spec/dummy/db", "spec/dummy/db/schema.rb", "spec/dummy/db/migrate", "spec/dummy/db/migrate/20131030014902_create_comments.rb", "spec/dummy/db/migrate/20131029211126_create_users.rb", "spec/dummy/db/migrate/20131030014901_create_recipes.rb", "spec/dummy/config", "spec/dummy/config/environment.rb", "spec/dummy/config/environments", "spec/dummy/config/environments/production.rb", "spec/dummy/config/environments/test.rb", "spec/dummy/config/environments/development.rb", "spec/dummy/config/initializers", "spec/dummy/config/initializers/mime_types.rb", "spec/dummy/config/initializers/inflections.rb", "spec/dummy/config/initializers/session_store.rb", "spec/dummy/config/initializers/secret_token.rb", "spec/dummy/config/initializers/wrap_parameters.rb", "spec/dummy/config/initializers/backtrace_silencers.rb", "spec/dummy/config/initializers/filter_parameter_logging.rb", "spec/dummy/config/application.rb", "spec/dummy/config/locales", "spec/dummy/config/locales/en.yml", "spec/dummy/config/routes.rb", "spec/dummy/config/boot.rb", "spec/dummy/config/database.yml", "spec/dummy/Rakefile", "spec/dummy/config.ru", "spec/dummy/README.rdoc"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 4.0.0", "~> 4.0"])
      s.add_runtime_dependency(%q<request_store>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 3.0.0", "~> 3.0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 3.0.2", "~> 3.0"])
      s.add_development_dependency(%q<rspec-collection_matchers>, [">= 1.0.0", "~> 1.0"])
      s.add_development_dependency(%q<shoulda>, [">= 3.5.0", "~> 3.5"])
      s.add_development_dependency(%q<shoulda-matchers>, [">= 2.7.0", "~> 2.7"])
      s.add_development_dependency(%q<shoulda-context>, [">= 1.2.1", "~> 1.2"])
      s.add_development_dependency(%q<factory_girl>, [">= 4.4.0", "~> 4.4"])
      s.add_development_dependency(%q<factory_girl_rails>, [">= 4.4.1", "~> 4.4"])
      s.add_development_dependency(%q<faker>, [">= 1.4.2", "~> 1.4"])
      s.add_development_dependency(%q<database_cleaner>, [">= 1.3.0", "~> 1.3"])
      s.add_development_dependency(%q<capybara>, [">= 2.4.3", "~> 2.4"])
      s.add_development_dependency(%q<simplecov>, [">= 0.9.1", "~> 0.9"])
      s.add_development_dependency(%q<simplecov-rcov>, [">= 0.2.3", "~> 0.2"])
    else
      s.add_dependency(%q<rails>, [">= 4.0.0", "~> 4.0"])
      s.add_dependency(%q<request_store>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 3.0.0", "~> 3.0"])
      s.add_dependency(%q<rspec-rails>, [">= 3.0.2", "~> 3.0"])
      s.add_dependency(%q<rspec-collection_matchers>, [">= 1.0.0", "~> 1.0"])
      s.add_dependency(%q<shoulda>, [">= 3.5.0", "~> 3.5"])
      s.add_dependency(%q<shoulda-matchers>, [">= 2.7.0", "~> 2.7"])
      s.add_dependency(%q<shoulda-context>, [">= 1.2.1", "~> 1.2"])
      s.add_dependency(%q<factory_girl>, [">= 4.4.0", "~> 4.4"])
      s.add_dependency(%q<factory_girl_rails>, [">= 4.4.1", "~> 4.4"])
      s.add_dependency(%q<faker>, [">= 1.4.2", "~> 1.4"])
      s.add_dependency(%q<database_cleaner>, [">= 1.3.0", "~> 1.3"])
      s.add_dependency(%q<capybara>, [">= 2.4.3", "~> 2.4"])
      s.add_dependency(%q<simplecov>, [">= 0.9.1", "~> 0.9"])
      s.add_dependency(%q<simplecov-rcov>, [">= 0.2.3", "~> 0.2"])
    end
  else
    s.add_dependency(%q<rails>, [">= 4.0.0", "~> 4.0"])
    s.add_dependency(%q<request_store>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 3.0.0", "~> 3.0"])
    s.add_dependency(%q<rspec-rails>, [">= 3.0.2", "~> 3.0"])
    s.add_dependency(%q<rspec-collection_matchers>, [">= 1.0.0", "~> 1.0"])
    s.add_dependency(%q<shoulda>, [">= 3.5.0", "~> 3.5"])
    s.add_dependency(%q<shoulda-matchers>, [">= 2.7.0", "~> 2.7"])
    s.add_dependency(%q<shoulda-context>, [">= 1.2.1", "~> 1.2"])
    s.add_dependency(%q<factory_girl>, [">= 4.4.0", "~> 4.4"])
    s.add_dependency(%q<factory_girl_rails>, [">= 4.4.1", "~> 4.4"])
    s.add_dependency(%q<faker>, [">= 1.4.2", "~> 1.4"])
    s.add_dependency(%q<database_cleaner>, [">= 1.3.0", "~> 1.3"])
    s.add_dependency(%q<capybara>, [">= 2.4.3", "~> 2.4"])
    s.add_dependency(%q<simplecov>, [">= 0.9.1", "~> 0.9"])
    s.add_dependency(%q<simplecov-rcov>, [">= 0.2.3", "~> 0.2"])
  end
end
