class ApiKeyDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    {
      id: id,
      key_id: key_id,
      v_code: v_code
    }
  end
end
