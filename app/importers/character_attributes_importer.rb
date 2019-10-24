# frozen_string_literal: true

class CharacterAttributesImporter
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    character = Character.find_by!(character_id: character_id)

    esi = EveOnline::ESI::CharacterAttributes.new(character_id: character_id,
                                                  token: character.access_token)

    character.update!(esi.as_json)
  rescue EveOnline::Exceptions::ResourceNotFound
    character.destroy!
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  rescue EveOnline::Exceptions::Forbidden
    Api::RefreshCharacterAccessToken.new(character_id).refresh
  end
end
