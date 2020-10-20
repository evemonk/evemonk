# frozen_string_literal: true

class CharacterAttributesImporter < CharacterBaseImporter
  def import!
    character.update!(esi.as_json)
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterAttributes.new(character_id: character.character_id)
  end
end
