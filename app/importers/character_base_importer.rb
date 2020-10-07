# frozen_string_literal: true

class CharacterBaseImporter
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    refresh_character_access_token

    configure_esi_middlewares

    ActiveRecord::Base.transaction do
      import!
    end
  rescue EveOnline::Exceptions::ResourceNotFound
    Rails.logger.info("WARNING: ESI response with 404 (NOT FOUND) for Character with ID #{character_id}")
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  rescue CharacterInvalidToken
    Rails.logger.info("Invalid character token for Character with ID #{character_id}")
  end

  private

  def character
    @character ||= Character.lock.find_by!(character_id: character_id)
  end

  def import!
    raise NotImplementedError
  end

  def esi
    raise NotImplementedError
  end

  def configure_esi_middlewares
    middlewares = [EveOnline::Middlewares::UpdateRedisStats]

    middlewares.each do |middleware|
      esi.add_after_middleware(middleware)
    end
  end

  def refresh_character_access_token
    Api::RefreshCharacterAccessToken.new(character).refresh
  end

  def character_scope_present?(scope)
    character.scopes.include?(scope)
  end
end
