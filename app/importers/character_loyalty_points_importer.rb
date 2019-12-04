# frozen_string_literal: true

class CharacterLoyaltyPointsImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token

    esi = EveOnline::ESI::CharacterLoyaltyPoints.new(character_id: character.character_id,
                                                     token: character.access_token)

    return unless character_scope_present?(esi.scope)

    character.loyalty_points.destroy_all

    esi.loyalty_points.each do |lp|
      character_lp = character.loyalty_points.find_or_initialize_by(corporation_id: lp.corporation_id)
      character_lp.assign_attributes(lp.as_json)
      character_lp.save!
    end
  end
end
