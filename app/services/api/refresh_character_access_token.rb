# frozen_string_literal: true

module Api
  class RefreshCharacterAccessToken
    attr_reader :character_id

    def initialize(character_id)
      @character_id = character_id
    end

    def refresh
      character = Character.find_by(character_id: character_id)

      return unless character.token_expired?

      oauth_client_options = OmniAuth::Strategies::EveOnlineSso.default_options["client_options"]

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
    end
  end
end
