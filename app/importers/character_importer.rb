# frozen_string_literal: true

class CharacterImporter < CharacterBaseImporter
  def update!
    esi = EveOnline::ESI::Character.new(character_id: character_id)

    # FIXME: character security status always updates
    character.update!(esi.as_json)
  end
end
