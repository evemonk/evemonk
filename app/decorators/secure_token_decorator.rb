class SecureTokenDecorator < Draper::Decorator
  delegate_all

  def as_json(*)
    {
      id: id,
      name: name,
      created_at: created_at,
      updated_at: updated_at
    }.tap do |hash|
      hash[:token] = token if context[:with_token]
    end
  end

  private

  def created_at
    model.created_at.iso8601
  end

  def updated_at
    model.updated_at.iso8601
  end
end
