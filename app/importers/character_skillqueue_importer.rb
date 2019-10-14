# frozen_string_literal: true

class CharacterSkillqueueImporter
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    character = Character.find_by!(character_id: character_id)

    esi = EveOnline::ESI::CharacterSkillQueue.new(character_id: character_id,
                                                  token: character.access_token)

    ActiveRecord::Base.transaction do
      character.skillqueues.destroy_all

      esi.skills.each do |skill|
        character.skillqueues.create!(skill.as_json)
      end
    end
  end
end
