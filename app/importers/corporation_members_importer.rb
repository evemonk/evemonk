# frozen_string_literal: true

class CorporationMembersImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token

    esi = EveOnline::ESI::CorporationMembers.new(corporation_id: character.corporation_id,
                                                 token: character.access_token)

    return unless character_scope_present?(esi.scope)

    esi.character_ids.each do |character_id|
      Eve::UpdateCharacterJob.perform_later(character_id)
    end
  end
end
