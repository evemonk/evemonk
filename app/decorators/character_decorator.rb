# frozen_string_literal: true

class CharacterDecorator < ApplicationDecorator
  include ActionView::Helpers::NumberHelper

  decorates_associations :user, :race, :bloodline, :faction, :ancestry,
    :alliance, :corporation, :loyalty_points, :character_assets, :character_implants,
    :implants

  def birthday
    object.birthday&.iso8601
  end

  def icon_tiny
    "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_32.jpg"
  end

  def icon_small
    "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_64.jpg"
  end

  def icon_medium
    "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_128.jpg"
  end

  def icon_large
    "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_256.jpg"
  end

  def icon_huge
    "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_512.jpg"
  end

  def icon_gigantic
    "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_1024.jpg"
  end

  def description
    Rails::Html::FullSanitizer.new.sanitize(object.description)
  end

  def security_status
    object.security_status.to_s
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

  def wallet_formatted
    number_with_delimiter(object.wallet.to_i, delimiter: ",")
  end

  def total_sp_formatted
    number_with_delimiter(object.total_sp, delimiter: ",")
  end

  def unallocated_sp_formatted
    number_with_delimiter(object.unallocated_sp, delimiter: ",")
  end
end
