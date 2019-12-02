# frozen_string_literal: true

class CharacterLoyaltyPointsImporter
  include CharacterAccessToken

  attr_reader :character_id, :character

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    ActiveRecord::Base.transaction do
      character = Character.lock.find_by!(character_id: character_id)

      refresh_character_access_token(character)

      esi = EveOnline::ESI::CharacterLoyaltyPoints.new(character_id: character.character_id,
                                                       token: character.access_token)

      return unless character.scopes.include?(esi.scope)

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
