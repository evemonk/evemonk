# frozen_string_literal: true

class CharacterDecorator < ApplicationDecorator
  include ActionView::Helpers::NumberHelper

  decorates_associations :user, :race, :bloodline, :faction, :ancestry,
    :alliance, :corporation, :current_ship_type, :current_solar_system,
    :current_station, :loyalty_points, :character_assets, :character_implants,
    :implants, :skillqueues, :character_skills,
    :character_corporation_histories, :character_mail_labels

  def birthday
    object.birthday&.iso8601
  end

  def birthday_formatted
    object.birthday&.strftime("%Y.%m.%d")
  end

  def icon_tiny
    "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=32&tenant=tranquility"
  end

  def icon_small
    "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=64&tenant=tranquility"
  end

  def icon_medium
    "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=128&tenant=tranquility"
  end

  def icon_large
    "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=256&tenant=tranquility"
  end

  def icon_huge
    "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=512&tenant=tranquility"
  end

  def icon_gigantic
    "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=1024&tenant=tranquility"
  end

  def description
    Rails::Html::FullSanitizer.new.sanitize(object.description)
  end

  def security_status
    object.security_status.round(1).to_s
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
    number_with_delimiter(object.wallet.to_i)
  end

  def total_sp_formatted
    number_with_delimiter(object.total_sp)
  end

  def unallocated_sp_formatted
    number_with_delimiter(object.unallocated_sp)
  end

  # def neural_remap_available
  #   if object.accrued_remap_cooldown_date&.past?
  #     "Now"
  #   else
  #     object.accrued_remap_cooldown_date&.strftime("%b %d, %Y")
  #   end
  # end
end
