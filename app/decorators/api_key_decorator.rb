class ApiKeyDecorator < Draper::Decorator
  delegate_all

  def as_json(*)
    {
      id: id,
      key_id: key_id,
      v_code: v_code,
      status: status,
      created_at: created_at.iso8601,
      updated_at: updated_at.iso8601
    }
  end
end
