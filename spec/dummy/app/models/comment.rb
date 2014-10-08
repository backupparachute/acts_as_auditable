class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  ## Audited
  auditable associated_with: :recipe
end
