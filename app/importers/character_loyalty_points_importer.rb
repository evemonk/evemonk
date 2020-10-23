# frozen_string_literal: true

class CharacterLoyaltyPointsImporter < CharacterBaseImporter
  def import!
    character.loyalty_points.destroy_all

    esi.loyalty_points.each do |lp|
      character_lp = character.loyalty_points.find_or_initialize_by(corporation_id: lp.corporation_id)
      character_lp.assign_attributes(lp.as_json)
      character_lp.save!
    end
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterLoyaltyPoints.new(character_id: character.character_id)
  end
end
