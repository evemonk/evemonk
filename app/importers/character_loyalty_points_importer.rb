# frozen_string_literal: true

class CharacterLoyaltyPointsImporter
  include CharacterAccessToken

  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    character = Character.find_by!(character_id: character_id)

    refresh_character_access_token

    esi = EveOnline::ESI::CharacterLoyaltyPoints.new(character_id: character_id,
                                                     token: character.access_token)

    ActiveRecord::Base.transaction do
      character.loyalty_points.destroy_all

      esi.loyalty_points.each do |lp|
        character_lp = character.loyalty_points.find_or_initialize_by(corporation_id: lp.corporation_id)
        character_lp.assign_attributes(lp.as_json)
        character_lp.save!
      end
    end
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end
end
