# frozen_string_literal: true

module Api
  class RefreshCharacterAccessToken
    attr_reader :character

    def initialize(character)
      @character = character
    end

    def refresh
      return unless character.token_expired?

      oauth_client_options = OmniAuth::Strategies::EveOnlineSso.default_options["client_options"].deep_symbolize_keys

      oauth_client = OAuth2::Client.new(Setting.eve_online_sso_client_id,
        Setting.eve_online_sso_secret_key,
        oauth_client_options)

      response = OAuth2::AccessToken.from_hash(oauth_client,
        refresh_token: character.refresh_token)
        .refresh!

      character.update!(access_token: response.token,
        refresh_token: response.refresh_token,
        token_expires_at: Time.zone.at(response.expires_at),
        token_expires: response.expires?)
    rescue OAuth2::Error => e
      if e.code == "invalid_token"
        character.update!(esi_token_valid: false,
          esi_token_invalid_at: Time.zone.now,
          esi_last_error: e.description)
      end

      Rails.logger.info("OAuth2::Error: Character ID: #{character.character_id} / code: #{e.code} / description: #{e.description}")

      raise CharacterInvalidToken
    end
  end
end
