# frozen_string_literal: true

class CharacterDecorator
  def birthday
    object.birthday&.iso8601
  end

  def security_status
    object.security_status&.round(1)&.to_s
  end

  def wallet
    object.wallet.to_i
  end
end
