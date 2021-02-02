# frozen_string_literal: true

class CharacterDecorator
  def birthday
    object.birthday&.iso8601
  end

  def description
    Rails::Html::FullSanitizer.new.sanitize(object.description)
  end

  def security_status
    object.security_status&.round(1)&.to_s
  end

  def last_remap_date
    object.last_remap_date&.iso8601
  end

  def accrued_remap_cooldown_date
    object.accrued_remap_cooldown_date&.iso8601
  end

  def wallet
    object.wallet.to_i
  end
end
