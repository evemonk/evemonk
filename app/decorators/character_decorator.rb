# frozen_string_literal: true

class CharacterDecorator < ApplicationDecorator
  include ActionView::Helpers::NumberHelper

  decorates_associations :user, :race, :bloodline, :faction, :ancestry,
    :alliance, :corporation, :current_ship_type, :current_solar_system,
    :current_station, :etags, :loyalty_points, :character_assets,
    :character_implants, :implants, :skillqueues, :character_skills,
    :character_corporation_histories, :character_mail_labels, :standings,
    :character_killmails, :wallet_journals, :wallet_transactions,
    :character_blueprints, :industry_jobs, :character_orders,
    :manufacturing_jobs, :factions_standings, :corporations_standings,
    :agents_standings

  def birthday
    object.birthday&.iso8601
  end

  def birthday_formatted
    object.birthday&.strftime("%Y.%m.%d")
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

  def wallet_formatted
    number_with_delimiter(object.wallet.to_i, delimiter: " ")
  end

  def total_sp_formatted
    number_with_delimiter(object.total_sp, delimiter: " ")
  end

  def unallocated_sp_formatted
    number_with_delimiter(object.unallocated_sp, delimiter: " ")
  end

  def full_sp_formatted
    number_with_delimiter(object.total_sp.to_i + object.unallocated_sp.to_i, delimiter: " ")
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
