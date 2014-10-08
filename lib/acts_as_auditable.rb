require 'acts_as_auditable/engine'
require 'request_store'

module ActsAsAuditable

  autoload :Auditor,         'acts_as_auditable/auditor'
  autoload :AuditorBehavior, 'acts_as_auditable/auditor_behavior'
  autoload :AuditorRequest,  'acts_as_auditable/auditor_request'

  class << self

    attr_accessor :current_user_method

    def current_user_method
      @current_user_method ||= :current_user
    end

  end

end
