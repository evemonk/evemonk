# frozen_string_literal: true

class CharacterSkillsImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token

    esi = EveOnline::ESI::CharacterSkills.new(character_id: character.character_id,
                                              token: character.access_token)

    return unless character_scope_present?(esi.scope)

    character.update!(total_sp: esi.total_sp,
                      unallocated_sp: esi.unallocated_sp)

    character.character_skills.destroy_all

    esi.skills.each do |skill|
      character.character_skills.create!(skill.as_json)
    end
  end
end
