# frozen_string_literal: true

class CharacterImplantsImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token

    esi = EveOnline::ESI::CharacterImplants.new(character_id: character.character_id,
                                                token: character.access_token)

    return unless character_scope_present?(esi.scope)

    character.character_implants.destroy_all

    esi.implant_ids.each do |implant_id|
      character.character_implants.create!(type_id: implant_id)
    end
  end
end
