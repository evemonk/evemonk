class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at

  has_many :sessions

  has_many :api_keys

  def created_at
    object.created_at.iso8601
  end

  def updated_at
    object.updated_at.iso8601
  end

  def json_key
    nil
  end
end
