# frozen_string_literal: true

class CharacterAssetsImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token(character)

    esi = EveOnline::ESI::CharacterAssets.new(character_id: character.character_id,
                                              token: character.access_token)

    return unless character_scope_present?(esi.scope)

    character.character_assets.destroy_all

    esi.assets.each do |asset|
      character.character_assets.create!(asset.as_json)
    end
  end
end
