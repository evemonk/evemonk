# frozen_string_literal: true

class CharacterDecorator
  def wallet
    object.wallet.to_i
  end
end
