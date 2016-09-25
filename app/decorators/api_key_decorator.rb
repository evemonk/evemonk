class ApiKeyDecorator < Draper::Decorator
  delegate_all

  # rubocop:disable Lint/UnusedMethodArgument
  def as_json(*args)
    {
      id: id,
      key_id: key_id,
      v_code: v_code
    }
  end
  # rubocop:enable Lint/UnusedMethodArgument

  private

  def created_at
    model.created_at.iso8601
  end

  def updated_at
    model.updated_at.iso8601
  end
end
