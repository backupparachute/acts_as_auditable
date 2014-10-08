require 'coveralls'
Coveralls.wear!

require 'simplecov'
require 'simplecov-rcov'

## Configure SimpleCov
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::RcovFormatter
]

SimpleCov.start 'rails'

ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../spec/dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/collection_matchers'
require 'capybara/rails'
require 'factory_girl_rails'
require 'database_cleaner'
require 'faker'
require 'shoulda/matchers'
require 'shoulda/context'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
# ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods

  config.color = true
  config.fail_fast = false

  config.infer_base_class_for_anonymous_controllers = false

  config.before(:suite) do
    FactoryGirl.lint
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
  end
end
