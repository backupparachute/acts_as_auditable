module ActsAsAuditable
  class Engine < ::Rails::Engine

    isolate_namespace ActsAsAuditable

    config.generators do |g|
      g.test_framework  :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.integration_tool :rspec
      g.assets false
      g.helper false
    end

    initializer "include Auditor request into action controller" do |app|
      ActionController::Base.send(:include, ActsAsAuditable::AuditorRequest)
      ActiveRecord::Base.send(:include, ActsAsAuditable::Auditor)
    end

  end
end
