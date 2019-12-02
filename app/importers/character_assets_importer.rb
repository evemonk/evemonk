# frozen_string_literal: true

class CharacterAssetsImporter
  include CharacterAccessToken

  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    ActiveRecord::Base.transaction do
      character = Character.lock.find_by!(character_id: character_id)

      refresh_character_access_token(character)

      esi = EveOnline::ESI::CharacterAssets.new(character_id: character.character_id,
                                                token: character.access_token)

      return unless character.scopes.include?(esi.scope)

      character.character_assets.destroy_all

      esi.assets.each do |asset|
        character.character_assets.create!(asset.as_json)
      end
    end
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end
end
