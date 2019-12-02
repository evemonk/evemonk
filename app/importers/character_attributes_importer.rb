# frozen_string_literal: true

class CharacterAttributesImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token

    esi = EveOnline::ESI::CharacterAttributes.new(character_id: character.character_id,
                                                  token: character.access_token)

    return unless character_scope_present?(esi.scope)

    character.update!(esi.as_json)
  end
end
