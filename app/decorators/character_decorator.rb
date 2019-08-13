# frozen_string_literal: true

class CharacterDecorator < ApplicationDecorator
  decorates_associations :user, :race, :bloodline, :faction, :ancestry,
                         :alliance, :corporation

  def birthday
    object.birthday.iso8601
  end

  def icon_tiny
    "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_32.png"
  end

  def icon_small
    "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_64.png"
  end

  def icon_medium
    "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_128.png"
  end

  def icon_large
    "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_256.png"
  end

  def icon_huge
    "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_512.png"
  end

  def icon_gigantic
    "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_1024.png"
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
    "#{object.wallet} ISK"
  end
end
