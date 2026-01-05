# frozen_string_literal: true

class CharacterOnlineImporter < CharacterBaseImporter
  def import!
    character.update!(online: esi.online)
  end

  def scope
    "esi-location.read_online.v1"
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterOnline.new(character_id: character.character_id)
  end
end
