# frozen_string_literal: true

class SessionDecorator < Draper::Decorator
  delegate_all

  # rubocop:disable Metrics/MethodLength
  def as_json(*)
    {
      id: id,
      name: name,
      created_at: created_at.iso8601,
      updated_at: updated_at.iso8601
    }.tap do |hash|
      if context[:with_token]
        hash[:token] = token

        hash[:device] = device

        hash[:device_token] = device_token
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
end
