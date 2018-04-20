# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  def as_json(*)
    {
      id: id,
      email: email,
      created_at: created_at.iso8601,
      updated_at: updated_at.iso8601
    }
  end
end
