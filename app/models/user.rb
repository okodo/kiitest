class User < ActiveRecord::Base

  ## Authorization with devise
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates :email, uniqueness: true, presence: true, email: true

  ## Relationships
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy

end
