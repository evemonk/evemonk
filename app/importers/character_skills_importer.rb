# frozen_string_literal: true

class CharacterSkillsImporter < CharacterBaseImporter
  def import!
    character.update!(total_sp: esi.total_sp,
      unallocated_sp: esi.unallocated_sp)

    character.character_skills.destroy_all

    esi.skills.each do |skill|
      character.character_skills.create!(skill.as_json)
    end
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterSkills.new(character_id: character.character_id)
  end
end
