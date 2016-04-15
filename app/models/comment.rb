class Comment < ActiveRecord::Base

  ## Relationships
  belongs_to :event
  belongs_to :user

  ## Validation
  validates :body, presence: true

  ## Named scopes
  default_scope { order('comments.created_at ASC') }

end
