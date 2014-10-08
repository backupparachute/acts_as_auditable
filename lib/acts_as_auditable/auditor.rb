module ActsAsAuditable
  module Auditor
    extend ActiveSupport::Concern
    include ActsAsAuditable::AuditorBehavior
  end
end
