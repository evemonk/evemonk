# frozen_string_literal: true

module CharacterAccessToken
  def refresh_character_access_token
    Api::RefreshCharacterAccessToken.new(character_id).refresh
  end
end
