class SecureTokenDecorator < Draper::Decorator
  delegate_all

  def as_json(*)
    {
      id: id,
      token: token,
      name: name,
      created_at: created_at,
      updated_at: updated_at
    }
  end

  private

  def created_at
    model.created_at.iso8601
  end

  def updated_at
    model.updated_at.iso8601
  end
end
