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

  # def last_clone_jump_date_formatted
  #   object.last_clone_jump_date&.strftime("%Y.%m.%d")
  # end

  # add_column :characters, :last_clone_jump_date, :datetime
  # add_column :characters, :last_station_change_date, :datetime

  # def neural_remap_available
  #   if object.accrued_remap_cooldown_date&.past?
  #     "Now"
  #   else
  #     object.accrued_remap_cooldown_date&.strftime("%b %d, %Y")
  #   end
  # end
end
