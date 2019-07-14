# frozen_string_literal: true

class CharacterDecorator < ApplicationDecorator
  decorates_associations :user, :race, :bloodline, :faction, :ancestry,
                         :alliance, :corporation

  def birthday
    object.birthday.iso8601
  end

  def icon
    "https://imageserver.eveonline.com/Character/#{ character_id }_512.jpg"
  end

  def description
    Rails::Html::FullSanitizer.new.sanitize(object.description)
  end

  def security_status
    object.security_status.to_s
  end

  def last_remap_date
    object.last_remap_date.iso8601
  end

  def accrued_remap_cooldown_date
    object.accrued_remap_cooldown_date.iso8601
  end

  def wallet
    "#{ object.wallet } ISK"
  end
end
