class SessionDecorator < Draper::Decorator
  delegate_all

  def as_json(*)
    {
      id: id,
      name: name,
      device: device,
      created_at: created_at,
      updated_at: updated_at
    }.tap do |hash|
      if context[:with_token]
        hash[:token] = token

        hash[:device_token] = device_token
      end
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
