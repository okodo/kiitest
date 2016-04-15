class UserSerializer < ActiveModel::Serializer

  attributes :id, :fullname, :email, :created_at, :updated_at

  def attributes
    hash = super
    hash[:errors] = object.errors.messages if object.errors.any?
    hash
  end

end
