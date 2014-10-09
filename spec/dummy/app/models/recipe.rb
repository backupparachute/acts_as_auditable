class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many   :comments, dependent: :destroy

  ## Audited
  acts_as_auditable
  has_associated_audits
end
