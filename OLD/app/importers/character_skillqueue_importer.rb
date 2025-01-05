# frozen_string_literal: true

class CharacterSkillqueueImporter < CharacterBaseImporter
  def import!
    character.skillqueues.destroy_all

    esi.skills.each do |skill|
      character.skillqueues.create!(skill.as_json)
    end
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterSkillQueue.new(character_id: character.character_id)
  end
end
