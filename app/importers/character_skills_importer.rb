# frozen_string_literal: true

class CharacterSkillsImporter
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    character = Character.find_by!(character_id: character_id)

    esi = EveOnline::ESI::CharacterSkills.new(character_id: character_id,
                                              token: character.access_token)

    ActiveRecord::Base.transaction do
      character.update!(total_sp: esi.total_sp)

      character.update!(unallocated_sp: esi.unallocated_sp)

      character.character_skills.destroy_all

      esi.skills.each do |skill|
        character.character_skills.create!(skill.as_json)
      end
    end
  end
end
