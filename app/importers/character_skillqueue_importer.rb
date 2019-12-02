# frozen_string_literal: true

class CharacterSkillqueueImporter
  include CharacterAccessToken

  attr_reader :character_id, :character

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    ActiveRecord::Base.transaction do
      character = Character.lock.find_by!(character_id: character_id)

      refresh_character_access_token(character)

      esi = EveOnline::ESI::CharacterSkillQueue.new(character_id: character.character_id,
                                                    token: character.access_token)

      return unless character.scopes.include?(esi.scope)

      character.skillqueues.destroy_all

      esi.skills.each do |skill|
        character.skillqueues.create!(skill.as_json)
      end
    end
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end
end
