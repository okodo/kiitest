class Event < ActiveRecord::Base

  ## Relationships
  belongs_to :user
  has_many :comments, dependent: :destroy

  ## Attributes customization
  enum recurs_on: %i(n_a day week month year)

  ## Validation
  validates :title, presence: true
  validates_datetime :starts_at

end
