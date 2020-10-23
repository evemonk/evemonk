# frozen_string_literal: true

class CharacterImplantsImporter < CharacterBaseImporter
  def import!
    character.character_implants.destroy_all

    esi.implant_ids.each do |implant_id|
      character.character_implants.create!(type_id: implant_id)
    end
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterImplants.new(character_id: character.character_id)
  end
end
