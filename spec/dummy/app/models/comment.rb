class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  ## Audited
  acts_as_auditable associated_with: :recipe
end
