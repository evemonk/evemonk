# frozen_string_literal: true

class CharacterBaseImporter
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    ActiveRecord::Base.transaction do
      update!
    end
  rescue EveOnline::Exceptions::ResourceNotFound
    character.destroy!
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end

  def character
    @character ||= Character.lock.find_by!(character_id: character_id)
  end

  def update!
    raise NotImplementedError
  end

  def refresh_character_access_token
    Api::RefreshCharacterAccessToken.new(character).refresh
  end

  def character_scope_present?(scope)
    character.scopes.include?(scope)
  end
end
