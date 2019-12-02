# frozen_string_literal: true

module CharacterAccessToken
  def refresh_character_access_token(character)
    Api::RefreshCharacterAccessToken.new(character).refresh
  end
end
