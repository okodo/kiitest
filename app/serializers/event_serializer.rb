class EventSerializer < ActiveModel::Serializer

  attributes :id, :title, :starts_at, :recurs_on, :created_at, :updated_at, :type

  def attributes
    hash = super
    hash[:errors] = object.errors.messages if object.errors.any?
    hash
  end

  def type
    'info'
  end

  has_one :user
  has_many :comments

end
