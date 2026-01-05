# frozen_string_literal: true

class CharacterOnlineImporter < CharacterBaseImporter
  def import!
    character.update!(online: esi.online)
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterOnline.new(character_id: character.character_id)
  end
end
