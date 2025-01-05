# frozen_string_literal: true

class CorporationMembersImporter < CharacterBaseImporter
  def import!
    esi.character_ids.each do |character_id|
      Eve::UpdateCharacterJob.perform_later(character_id)
    end
  end

  def esi
    @esi ||= EveOnline::ESI::CorporationMembers.new(corporation_id: character.corporation_id)
  end
end
