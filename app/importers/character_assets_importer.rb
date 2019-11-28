# frozen_string_literal: true

class CharacterAssetsImporter
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    character = Character.find_by!(character_id: character_id)

    esi = EveOnline::ESI::CharacterAssets.new(character_id: character_id,
                                              token: character.access_token)

    ActiveRecord::Base.transaction do
      character.character_assets.destroy_all

      esi.assets.each do |asset|
        character.character_assets.create!(asset.as_json)
      end
    end
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end
end
