# frozen_string_literal: true

class CharacterAttributesImporter
  include CharacterAccessToken

  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    ActiveRecord::Base.transaction do
      character = Character.lock.find_by!(character_id: character_id)

      refresh_character_access_token(character)

      esi = EveOnline::ESI::CharacterAttributes.new(character_id: character.character_id,
                                                    token: character.access_token)

      return unless character.scopes.include?(esi.scope)

      character.update!(esi.as_json)
    end
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end
end
