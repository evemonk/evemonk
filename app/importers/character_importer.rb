# frozen_string_literal: true

class CharacterImporter < CharacterBaseImporter
  def import!
    # FIXME: character security status always updates
    character.update!(esi.as_json)
  end

  def esi
    @esi ||= EveOnline::ESI::Character.new(character_id: character.character_id)
  end
end
