class ApiKeySerializer < ActiveModel::Serializer
  attributes :id, :key_id, :v_code, :created_at, :updated_at

  def created_at
    object.created_at.iso8601
  end

  def updated_at
    object.updated_at.iso8601
  end
end
