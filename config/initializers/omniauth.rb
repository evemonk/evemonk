# frozen_string_literal: true

OmniAuth.config.full_host = 'https://evemonk.com'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :eve_online_sso,
           Setting.eve_online_sso_client_id,
           Setting.eve_online_sso_secret_key,
           scope: "esi-wallet.read_character_wallet.v1 esi-characters.read_loyalty.v1 esi-skills.read_skillqueue.v1 esi-skills.read_skills.v1 esi-assets.read_assets.v1 esi-location.read_location.v1 esi-location.read_online.v1 esi-location.read_ship_type.v1"
end
