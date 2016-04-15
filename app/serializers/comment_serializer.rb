class CommentSerializer < ActiveModel::Serializer

  attributes :id, :body, :created_at, :updated_at

  def attributes
    hash = super
    hash[:errors] = object.errors.messages if object.errors.any?
    hash
  end

  has_one :user

end
