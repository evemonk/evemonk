# frozen_string_literal: true

class CharacterSkillsImporter
  include CharacterAccessToken

  attr_reader :character_id, :character

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    ActiveRecord::Base.transaction do
      character = Character.lock.find_by!(character_id: character_id)

      refresh_character_access_token(character)

      esi = EveOnline::ESI::CharacterSkills.new(character_id: character.character_id,
                                                token: character.access_token)

      return unless character.scopes.include?(esi.scope)

      character.update!(total_sp: esi.total_sp,
                        unallocated_sp: esi.unallocated_sp)

      character.character_skills.destroy_all

      esi.skills.each do |skill|
        character.character_skills.create!(skill.as_json)
      end
    end
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end
end
